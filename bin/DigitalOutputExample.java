package com.pi4j.example.gpio.digital.output;
/*
https://github.com/Pi4J/pi4j-examples/blob/master/src/main/java/com/pi4j/example/gpio/digital/output/DigitalOutputExample.java
*/
/*-
 * #%L
 * **********************************************************************
 * ORGANIZATION  :  Pi4J
 * PROJECT       :  Pi4J :: EXAMPLE  :: Sample Code
 * FILENAME      :  DigitalOutputExample.java
 *
 * This file is part of the Pi4J project. More information about
 * this project can be found here:  https://pi4j.com/
 * **********************************************************************
 * %%
 * Copyright (C) 2012 - 2020 Pi4J
 * %%
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * #L%
 */

import com.pi4j.Pi4J;
import com.pi4j.io.gpio.digital.DigitalOutput;
import com.pi4j.io.gpio.digital.DigitalOutputProvider;
import com.pi4j.io.gpio.digital.DigitalState;
import com.pi4j.io.gpio.digital.DigitalStateChangeListener;
import com.pi4j.util.Console;
import java.util.concurrent.TimeUnit;

/**
 * <p>DigitalOutputExample class.</p>
 *
 * @author Robert Savage (<a href="http://www.savagehomeautomation.com">http://www.savagehomeautomation.com</a>)
 * @version $Id: $Id
 */
public class DigitalOutputExample {

    /** Constant <code>DIGITAL_OUTPUT_PIN=4</code> */
    public static final int DIGITAL_OUTPUT_PIN = 4;

    /**
     * <p>Constructor for DigitalOutputExample.</p>
     */
    public DigitalOutputExample() {
    }

    /**
     * <p>main.</p>
     *
     * @param args an array of {@link java.lang.String} objects.
     * @throws java.lang.Exception if any.
     */
    public static void main(String[] args) throws Exception {

        // create Pi4J console wrapper/helper
        // (This is a utility class to abstract some of the boilerplate stdin/stdout code)
        final var console = new Console();

        // print program title/header
        console.title("<-- The Pi4J Project -->", "Basic Digital Output Example");

        // allow for user to exit program using CTRL-C
        console.promptForExit();

        // Initialize Pi4J with an auto context
        // An auto context includes AUTO-DETECT BINDINGS enabled
        // which will load all detected Pi4J extension libraries
        // (Platforms and Providers) in the class path
        var pi4j = Pi4J.newAutoContext();


        // create a digital input instance using the default digital input provider
        // we will use the PULL_DOWN argument to set the pin pull-down resistance on this GPIO pin
        var config = DigitalOutput.newConfigBuilder(pi4j)
                .address(DIGITAL_OUTPUT_PIN)
                .shutdown(DigitalState.HIGH)
                .build();

        // get a Digital Input I/O provider from the Pi4J context
        DigitalOutputProvider digitalInputProvider = pi4j.provider("pigpio-digital-output");

        var output = digitalInputProvider.create(config);


        // setup a digital output listener to listen for any state changes on the digital output
        output.addListener(System.out::println);

        // lets invoke some changes on the digital output
        output.state(DigitalState.HIGH)
                .state(DigitalState.LOW)
                .state(DigitalState.HIGH)
                .state(DigitalState.LOW);

        // lets toggle the digital output state a few times
        output.toggle()
                .toggle()
                .toggle();


        // another friendly method of setting output state
        output.high()
                .low();

        // lets read the digital output state
        System.out.print("CURRENT DIGITAL OUTPUT [" + output + "] STATE IS [");
        System.out.println(output.state() + "]");

        // pulse to HIGH state for 3 seconds
        System.out.println("PULSING OUTPUT STATE TO HIGH FOR 3 SECONDS");
        output.pulse(3, TimeUnit.SECONDS, DigitalState.HIGH);
        System.out.println("PULSING OUTPUT STATE COMPLETE");

        // shutdown Pi4J
        console.println("ATTEMPTING TO SHUTDOWN/TERMINATE THIS PROGRAM");
        pi4j.shutdown();
    }
}
