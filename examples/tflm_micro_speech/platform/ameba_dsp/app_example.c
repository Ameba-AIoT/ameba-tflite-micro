#include "ameba_soc.h"
#include "FreeRTOS.h"
#include "task.h"

extern int micro_speech_test(void);

static void tflm_micro_speech_thread(void *param) {
    (void)param;
    vTaskDelay(1000);

    micro_speech_test();

    vTaskDelete(NULL);
}

void example_tflm_micro_speech(void) {
    if (xTaskCreate(tflm_micro_speech_thread, ((const char *)"tflm_micro_speech_thread"),
                    1024 * 4, NULL, tskIDLE_PRIORITY + 1, NULL) != pdPASS) {
        printf("\n\r%s create tflm_micro_speech_thread failed", __FUNCTION__);
    }
}

void app_example(void)
{
	example_tflm_micro_speech();
}
