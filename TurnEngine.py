import serial

def sendUserINput(instruction):
    ser = serial.Serial("COM4")
    ser.write(instruction)
    ser.close()

inst = ''
while(inst != "leave"):
    inst = raw_input("Instruction set: \n Turn on engine: On \n Turn off engine: Off \n Exit: Leave  \n ");
    inst = inst.lower()
    if(inst == 'off' or inst == 'on'):
        print(sendUserINput(inst))
    print("ending")