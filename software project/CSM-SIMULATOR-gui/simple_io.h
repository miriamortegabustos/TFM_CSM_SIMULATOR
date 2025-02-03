#ifndef SIMPLE_IO_H
#define SIMPLE_IO_H

#include <QtCore>
#include <stdint.h>

// outputs
#define INPUT_TEST_1        (1 << 0)
#define INPUT_TEST_2        (1 << 1)

// inputs
#define DSU_ACT             (1 << 0)

void simple_io_init(uint32_t);
bool get_input(uint32_t);
bool get_output(uint32_t);
bool set_output(uint32_t);
bool clr_output(uint32_t);

// TC Functions

int ena_input_test(QStringList);
int dis_input_test(QStringList);

#endif // SIMPLE_IO_H
