#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char **argv) {
  uint32_t num;
  float volume;
  float gain;
  float final;
  char input[8+1]; // null-terminated +1
  char output[8+1]; // null-terminated +1

  // Check arg size is ok
  if (argc != 3) {
    printf("usage: convert.exe [hex_value] [gain]");
    return 1;
  }

  // Check correct hex volume length
  if (strnlen(argv[1], 8) != 8) {
    printf("Error: string not correct length");
    return 1;
  }

  // convert argument reduction to float
  gain = atof(argv[2]);

  // check that reduction is in range
  if (gain < 0.0 || gain > 2.0) {
    printf("Error: invalid gain value");
    return 1;
  }

  // Reverse the hex string endian-ness
  input[0] = argv[1][6];
  input[1] = argv[1][7];
  input[2] = argv[1][4];
  input[3] = argv[1][5];
  input[4] = argv[1][2];
  input[5] = argv[1][3];
  input[6] = argv[1][0];
  input[7] = argv[1][1];
  
  // convert hex string to float
  sscanf(input, "%x", &num);
  volume = *((float*)&num);

  // calculate final volume
  final = volume * gain;

  // convert back to hex -> write it input (no longer used)
  sprintf(input, "%08x", *(unsigned int*) &final);

  // reverse the endian-ness again
  output[0] = input[6];
  output[1] = input[7];
  output[2] = input[4];
  output[3] = input[5];
  output[4] = input[2];
  output[5] = input[3];
  output[6] = input[0];
  output[7] = input[1];

  // print results (debug)
  //printf("initial: %.3f, final: %.3f, 0x%s", volume, final, output);
  
  // print converted value (in a format that xxd accepts)
  printf("00000A8: %.4s %s", output, &(output[4]));
}
