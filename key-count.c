#include <stdio.h>
#include <stdlib.h>
#include <linux/input.h>

char PATH[];

int main(){
    //linux structure for input events
    struct input_event ie;
    //size of structure
    size_t struct_size = sizeof(ie);
    //times key pressed
    int i = 0;
    //pointer to a keyevent file
    FILE *fptr;
    //opens file in read-binary mode
    fptr = fopen(PATH, "rb");
    //clear the screen
    system("clear");
    //forever loop
    while(1){
        //read the file to get event
        fread(&ie, struct_size, 1, fptr);
        //moves cursor to the start
        printf("\033[1;1H");
        //checks if event is key_press; according to library 0 - release, 1 - press and 2 - repeat
        if (ie.value == 1){
            printf("Times typed:%d\n",++i);
        }
    }

    fclose(fptr);

    return 0;
}
