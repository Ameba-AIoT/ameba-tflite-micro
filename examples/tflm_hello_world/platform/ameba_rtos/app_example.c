#include "ameba_soc.h"
#include "os_wrapper.h"

extern int tflmicro_hello_world(void);

static void tflm_hello_world_thread(void *param)
{
    (void)param;
    rtos_time_delay_ms(1000);
    tflmicro_hello_world();
    rtos_task_delete(NULL);
}

void example_tflm_hello_world(void)
{
    if (rtos_task_create(NULL, "example_tflm_hello_world_thread", tflm_hello_world_thread, NULL, 1024 * 6, 1) != RTK_SUCCESS) {
        printf("\n\r%s create example_tflm_hello_world_thread failed", __FUNCTION__);
    }
}

void app_example(void)
{
	example_tflm_hello_world();
}
