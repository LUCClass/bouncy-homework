
# Bouncy Square Homework

In this homework assignment, you will be drawing a square in video memory and
making it move around on the screen. Since emu8086 is so slow, we'll be running
the code in Qemu on Linux. You can reuse some of the functions you wrote in the
previous homework assignemnts.



## Basic Outline of the Program

0. Initialization: Initialize the (x,y) location of your square to something. I started mine at (10,10). You might also want to create two other variables deltaX and deltaY that store how much you will move the box each time you redraw the frame. 
1. Clear the screen by writing 0 to every byte in video RAM. You can either write a loop or modify your `memset` function from homework 1. Either way, make sure your DS register is set to `0xA000` before you start writing.
2. Call `drawRectangle` or whatever function you've written to draw a rectangle at the current (x,y) location.
3. Delay for a while. This will hold the frame on the screen so we can actually see it. Delay function is listed below.
4. Increment the x and y coordinates of the rectangle. You can do this by adding deltaX to x and deltaY to y.
5. Go back to 1.

        ; |----------------------|
        ; | Return Address       |
        ; |----------------------|
        ; | BP                   |
        ; |----------------------|
        ; | inner_count          |
        ; |----------------------|
        ; | outer_count          |
        ; |----------------------|
        delay:
            push bp                 ; Prologue
            mov bp,sp
            sub sp,4

            mov word [bp-2],0       ; Init two local variables to 0
            mov word [bp-4],0

        delay_outer_loop:
            inc word [bp-4]         ; Increment the outer loop counter
        delay_inner_loop:
            inc word [bp-2]         ; Increment inner loop counter
            cmp word [bp-2],0xffff  ; Check to see if we've maxed out the register
            jb delay_inner_loop     ; If not, keep incrementing inner counter

            ; MODIFY THIS CMP TO CHANGE THE DELAY AMOUNT
            cmp word [bp-4],30      ; Check if outer counter is big enough
            jb delay_outer_loop     ; If not keep looping

            mov sp,bp               ; Epilogue
            pop bp
            ret


