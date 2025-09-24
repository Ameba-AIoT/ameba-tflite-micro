#include "ameba_soc.h"
#include "os_wrapper.h"

extern int micro_speech_test(void);

static void example_tflm_micro_speech_thread(void *param) {
    (void)param;
    rtos_time_delay_ms(1000);

    micro_speech_test();

    rtos_task_delete(NULL);
}

void example_tflm_micro_speech(void) {
    if (rtos_task_create(NULL, "example_tflm_micro_speech_thread", example_tflm_micro_speech_thread, NULL,
                         1024 * 4, 1) != RTK_SUCCESS) {
        printf("\n\r%s create example_tflm_micro_speech_thread failed", __FUNCTION__);
    }
}

void app_example(void)
{
	example_tflm_micro_speech();
}
