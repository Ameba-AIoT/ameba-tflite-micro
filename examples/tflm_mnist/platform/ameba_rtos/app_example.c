#include "ameba_soc.h"
#include "os_wrapper.h"

extern int tflmicro_mnist(void);

unsigned int tflm_get_usec(void) {
    return DTimestamp_Get();
}

static void tflm_mnist_thread(void *param)
{
    (void)param;
    rtos_time_delay_ms(1000);
    tflmicro_mnist();
    rtos_task_delete(NULL);
}

void example_tflm_mnist(void)
{
    if (rtos_task_create(NULL, "example_tflm_mnist_thread", tflm_mnist_thread, NULL, 1024 * 4, 1) != RTK_SUCCESS) {
        printf("\n\r%s create example_tflm_mnist_thread failed", __FUNCTION__);
    }
}

void app_example(void)
{
	example_tflm_mnist();
}
