#include "ameba_soc.h"
#include "FreeRTOS.h"
#include "task.h"

unsigned int tflm_get_usec(void) {
	return (*((volatile uint32_t*)(0x4011E000 + 0x004)));
}

extern int tflmicro_mnist(void);

static void tflm_mnist_thread(void *param)
{
    (void)param;
    vTaskDelay(1000);
    tflmicro_mnist();
    vTaskDelete(NULL);
}

void example_tflm_mnist(void)
{
    if (xTaskCreate(tflm_mnist_thread, ((const char *)"example_tflm_mnist_thread"),
                    1024 * 4, NULL, tskIDLE_PRIORITY + 1, NULL) != pdPASS) {
        printf("\n\r%s create example_tflm_mnist_thread failed", __FUNCTION__);
    }
}

void app_example(void)
{
	example_tflm_mnist();
}
