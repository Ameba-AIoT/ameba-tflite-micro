#include "ameba_soc.h"
#include "FreeRTOS.h"
#include "task.h"

extern int tflmicro_hello_world(void);

static void tflm_hello_world_thread(void *param)
{
    (void)param;
    vTaskDelay(1000);

    tflmicro_hello_world();

    vTaskDelete(NULL);
}

void example_tflm_hello_world(void)
{
    if (xTaskCreate(tflm_hello_world_thread, ((const char *)"tflm_hello_world_thread"),
                    1024 * 6, NULL, tskIDLE_PRIORITY + 1, NULL) != pdPASS) {
        printf("\n\r%s create tflm_hello_world_thread failed", __FUNCTION__);
    }
}

void app_example(void)
{
	example_tflm_hello_world();
}
