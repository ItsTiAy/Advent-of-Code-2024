<cfscript>
    lines = application.inputReader.getInput();

    rA = reMatch("\d+", lines[1])[1];
    rB = reMatch("\d+", lines[2])[1];
    rC = reMatch("\d+", lines[3])[1];

    bigInt = createObject("java", "java.math.BigInteger");
    bigDec = createObject("java", "java.math.BigDecimal");

    registerA = bigInt.valueOf(rA);
    registerB = bigInt.valueOf(rB);
    registerC = bigInt.valueOf(rC);

    program = listToArray(listToArray(lines[5], " ")[2], ",");
    output = [];

    for (i = 1; i <= arrayLen(program); i += 2)
    {
        instruction = program[i];
        value = bigInt.valueOf(program[i + 1]);

        switch (instruction)
        {
            case 0:
                registerA = bigDec.valueOf(registerA  / (bigInt.valueOf("2").pow(combo(value)))).toBigInteger();
                break;
            case 1:
                registerB = bigInt.valueOf(registerB).xor(value);
                break;
            case 2:
                registerB = combo(value) % (bigInt.valueOf("8"));
                break;
            case 3:
                if (!registerA.equals(bigInt.valueOf("0")))
                {
                    i = value - bigInt.valueOf("1");
                }
                break;
            case 4:  
                registerB = bigInt.valueOf(registerB).xor(bigInt.valueOf(registerC));
                break;
            case 5:  
                arrayAppend(output, combo(value) % (bigInt.valueOf("8")));
                break;
            case 6:  
                registerB = bigDec.valueOf(registerA  / (bigInt.valueOf("2").pow(combo(value)))).toBigInteger();
                break;
            case 7:  
                registerC = bigDec.valueOf(registerA  / (bigInt.valueOf("2").pow(combo(value)))).toBigInteger();
                break;   
        }
    }

    writeOutput(arrayToList(output));

    private function combo(operand)
    {
        local.value = bigInt.valueOf("0");

        switch (operand)
        {
            case 0:  
            case 1:  
            case 2:  
            case 3:
                value = bigInt.valueOf(operand);
                break;
            case 4:
                value = bigInt.valueOf(registerA);
                break;
            case 5:
                value = bigInt.valueOf(registerB); 
                break;
            case 6:  
                value = bigInt.valueOf(registerC);
                break;
            case 7:  
                break;   
        }

        return value;
    }
</cfscript>

<!--- Answer: 7,4,2,0,5,0,5,3,7 --->