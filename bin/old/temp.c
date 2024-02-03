// --------------------------------------------------------------------------------------
static const char moduledocstring[] = "GPIO functionality of a Raspberry Pi using Python";

PyMethodDef rpi_gpio_methods[] = {
   {"setup", (PyCFunction)py_setup_channel, METH_VARARGS | METH_KEYWORDS, "Set up a GPIO channel or list of channels with a direction and (optional) pull/up down control\nchannel        - either board pin number or BCM number depending on which mode is set.\ndirection      - IN or OUT\n[pull_up_down] - PUD_OFF (default), PUD_UP or PUD_DOWN\n[initial]      - Initial value for an output channel"},
   {"cleanup", (PyCFunction)py_cleanup, METH_VARARGS | METH_KEYWORDS, "Clean up by resetting all GPIO channels that have been used by this program to INPUT with no pullup/pulldown and no event detection\n[channel] - individual channel or list/tuple of channels to clean up.  Default - clean every channel that has been used."},
   {"output", py_output_gpio, METH_VARARGS, "Output to a GPIO channel or list of channels\nchannel - either board pin number or BCM number depending on which mode is set.\nvalue   - 0/1 or False/True or LOW/HIGH"},
   {"input", py_input_gpio, METH_VARARGS, "Input from a GPIO channel.  Returns HIGH=1=True or LOW=0=False\nchannel - either board pin number or BCM number depending on which mode is set."},
   {"read_gpio", py_read_gpio, METH_VARARGS, "Returns the GPIO level.  Returns HIGH=1=True or LOW=0=False\nchannel - either board pin number or BCM number depending on which mode is set."},
   {"setmode", py_setmode, METH_VARARGS, "Set up numbering mode to use for channels.\nBOARD - Use Raspberry Pi board numbers\nBCM   - Use Broadcom GPIO 00..nn numbers"},
   {"getmode", py_getmode, METH_VARARGS, "Get numbering mode used for channel numbers.\nReturns BOARD, BCM or None"},
   {"add_event_detect", (PyCFunction)py_add_event_detect, METH_VARARGS | METH_KEYWORDS, "Enable edge detection events for a particular GPIO channel.\nchannel      - either board pin number or BCM number depending on which mode is set.\nedge         - RISING, FALLING or BOTH\n[callback]   - A callback function for the event (optional)\n[bouncetime] - Switch bounce timeout in ms for callback"},
   {"remove_event_detect", py_remove_event_detect, METH_VARARGS, "Remove edge detection for a particular GPIO channel\nchannel - either board pin number or BCM number depending on which mode is set."},
   {"event_detected", py_event_detected, METH_VARARGS, "Returns True if an edge has occurred on a given GPIO.  You need to enable edge detection using add_event_detect() first.\nchannel - either board pin number or BCM number depending on which mode is set."},
   {"add_event_callback", (PyCFunction)py_add_event_callback, METH_VARARGS | METH_KEYWORDS, "Add a callback for an event already defined using add_event_detect()\nchannel      - either board pin number or BCM number depending on which mode is set.\ncallback     - a callback function"},
   {"wait_for_edge", (PyCFunction)py_wait_for_edge, METH_VARARGS | METH_KEYWORDS, "Wait for an edge.  Returns the channel number or None on timeout.\nchannel      - either board pin number or BCM number depending on which mode is set.\nedge         - RISING, FALLING or BOTH\n[bouncetime] - time allowed between calls to allow for switchbounce\n[timeout]    - timeout in ms"},
   {"gpio_function", py_gpio_function, METH_VARARGS, "Return the current GPIO function (IN, OUT, PWM, SERIAL, I2C, SPI)\nchannel - either board pin number or BCM number depending on which mode is set."},
   {"get_alt", py_get_alt, METH_VARARGS, "Return the current GPIO mode (0-7)\nchannel - either board pin number or BCM number depending on which mode is set."},
   {"get_pullupdn", (PyCFunction)py_get_pullupdn, METH_VARARGS, "Return the current GPIO pull/up down \nchannel - either board pin number or BCM number depending on which mode is set."},
   {"setwarnings", py_setwarnings, METH_VARARGS, "Enable or disable warning messages"},
   {"get_PAD", (PyCFunction)py_get_PAD, METH_VARARGS, "Return the current PAD settings (slew, hyst, drive)\ngroup - 0-2"},
   {"set_drive", (PyCFunction)py_set_drive, METH_VARARGS | METH_KEYWORDS, "Set PAD drive\ngroup - 0-2\nvalue - 0-7"},
   {"set_hysteresis", (PyCFunction)py_set_hysteresis, METH_VARARGS | METH_KEYWORDS, "Set PAD hysteresis; 1 = enabled\ngroup - 0-2\nvalue - 0/1 or False/True"},
   {"set_slew", (PyCFunction)py_set_slew, METH_VARARGS | METH_KEYWORDS, "Set PAD slew rate; 1 = slew rate not limited\ngroup - 0-2\nvalue - 0/1 or False/True"},

   {"pwmsetmode", (PyCFunction)py_pwmsetmode, METH_VARARGS | METH_KEYWORDS, "Set native balanced mode PWM_MODE_BAL or standard mark:space mode PWM_MODE_MS\nvalue - 0/1"},
   {"pwmSetGpio", (PyCFunction)py_pwmSetGpio, METH_VARARGS | METH_KEYWORDS, "Put gpio pin into PWM mode\ngpio - either board pin number or BCM number depending on which mode is set."},
   {NULL, NULL, 0, NULL}
  };

#if PY_MAJOR_VERSION > 2
static struct PyModuleDef rpigpiomodule = {
   PyModuleDef_HEAD_INIT,
   "Pi._GPIO",      // name of module
   moduledocstring,  // module documentation, may be NULL
   -1,               // size of per-interpreter state of the module, or -1 if the module keeps state in global variables.
   rpi_gpio_methods
};
#endif

#if PY_MAJOR_VERSION > 2
PyMODINIT_FUNC PyInit__GPIO(void)
#else
PyMODINIT_FUNC init_GPIO(void)
#endif
{
   int i;
   PyObject *module = NULL;

#if PY_MAJOR_VERSION > 2
   if ((module = PyModule_Create(&rpigpiomodule)) == NULL)
      return NULL;
#else
   if ((module = Py_InitModule3("Pi._GPIO", rpi_gpio_methods, moduledocstring)) == NULL)
      return;
#endif

   define_constants(module);

   for (i=0; i<54; i++)
      gpio_direction[i] = -1;

   // detect board revision and set up accordingly
   if (get_rpi_info(&rpiinfo))
   {
      PyErr_SetString(PyExc_RuntimeError, "This module can only be run on a Raspberry Pi!");
      setup_error = 1;
#if PY_MAJOR_VERSION > 2
      return NULL;
#else
      return;
#endif
   }
   board_info = Py_BuildValue("{sissssssssss}",
                              "P1_REVISION",rpiinfo.p1_revision,
                              "REVISION",&rpiinfo.revision,
                              "TYPE",rpiinfo.type,
                              "MANUFACTURER",rpiinfo.manufacturer,
                              "PROCESSOR",rpiinfo.processor,
                              "RAM",rpiinfo.ram);
   PyModule_AddObject(module, "RPI_INFO", board_info);

   if (rpiinfo.p1_revision == 1) {
      pin_to_gpio = &pin_to_gpio_rev1;
   } else if (rpiinfo.p1_revision == 2) {
      pin_to_gpio = &pin_to_gpio_rev2;
   } else { // assume model B+ or A+ or 2B
      pin_to_gpio = &pin_to_gpio_rev3;
   }

   rpi_revision = Py_BuildValue("i", rpiinfo.p1_revision);     // deprecated
   PyModule_AddObject(module, "RPI_REVISION", rpi_revision);   // deprecated

   // Add PWM class
   if (PWM_init_PWMType() == NULL)
#if PY_MAJOR_VERSION > 2
      return NULL;
#else
      return;
#endif
   Py_INCREF(&PWMType);
   PyModule_AddObject(module, "PWM", (PyObject*)&PWMType);

#if PY_MAJOR_VERSION < 3 || PY_MINOR_VERSION < 7
   if (!PyEval_ThreadsInitialized())
      PyEval_InitThreads();
#endif

   // register exit functions - last declared is called first
   if (Py_AtExit(cleanup) != 0)
   {
      setup_error = 1;
      cleanup();
#if PY_MAJOR_VERSION > 2
      return NULL;
#else
      return;
#endif
   }

   if (Py_AtExit(event_cleanup_all) != 0)
   {
      setup_error = 1;
      cleanup();
#if PY_MAJOR_VERSION > 2
      return NULL;
#else
      return;
#endif
   }

#if PY_MAJOR_VERSION > 2
   return module;
#else
   return;
#endif
}
