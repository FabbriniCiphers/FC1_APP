#
# PKeyGen code by Michele Fabbrini in Julia Programming Language is made available  
# under the Creative Commons Attribution license. The following is a human-readable 
# summary of (and not a substitute for) the full legal text of the CC BY 4.0 license
# https://creativecommons.org/licenses/by/4.0/.
#
# You are free:
#
#  to Share—copy and redistribute the material in any medium or format
#  to Adapt—remix, transform, and build upon the material
#
# for any purpose, even commercially.
#
# The licensor cannot revoke these freedoms as long as you follow the license terms.
#
# Under the following terms:
#
# ATTRIBUTION — You must give appropriate credit (mentioning that your work is derived 
# from work by Michele Fabbrini), provide a link to the license, and indicate if 
# changes were made.
# You may do so in any reasonable manner, but not in any way that suggests the licensor
# endorses you or your use.
#
# No additional restrictions — You may not apply legal terms or technological measures 
# that legally restrict others from doing anything the license permits. 
# With the understanding that:
#
# Notices:
#
# You do not have to comply with the license for elements of the material in the public 
# domain or where your use is permitted by an applicable exception or limitation.
# No warranties are given. The license may not give you all of the permissions necessary 
# for your intended use. For example, other rights such as publicity, privacy, or moral 
# rights may limit how you use the material.
#
# JULIA LICENCE
#     
# MIT License
#
# Copyright (c) 2009-2022: Jeff Bezanson, Stefan Karpinski, Viral B. Shah, and other 
# contributors: https://github.com/JuliaLang/julia/contributors
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this
# software and associated documentation files (the "Software"), to deal in the Softwareù
# without restriction, including without limitation the rights to use, copy, modify, 
# merge, publish, distribute, sublicense, and/or sell copies of the Software, and to 
# permit persons to whom the Software is furnished to do so, subject to the following 
# conditions:
#
# The above copyright notice and this permission notice shall be included in all copies
# or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
# INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A 
# PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT 
# HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION 
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE 
# SOFTWARE OR THE USE OR  OTHER DEALINGS IN THE SOFTWARE.
#
# end of terms and conditions
#
# Please see THIRDPARTY.md for license information for other software used in this 
# project https://github.com/JuliaLang/julia/blob/master/THIRDPARTY.md

# PKeyGenPrimeMod - Version 1.0.0-beta 

using Pkg
using Primes
using Random 
using Base64

# Pkg.add("Primes")

####################
# Input Validation #
####################

# Input number of factors
println("\n")
function fcolorfactorsnum()
    for color in [:cyan]
printstyled("HOW MANY FACTORS SHOULD THE PRIMARY KEY HAVE?\n";color = color)
    end
end
fcolorfactorsnum()
println("[Please enter an integer, taking into account that later you can specify the minimum and maximum length.]")
println("                 ")
factorsnumb=readline()

# Input min primarykey length
println("A random function will now generate the factors whose min. and max. length you have to choose.\n")
println("                 ")

function fcolorminvalue()
    for color in [:cyan]
printstyled("WHAT MIN. NUMBER OF DIGITS SHOULD EACH FACTOR HAVE?";color = color)
println("\n")
    end
end
fcolorminvalue()

minlen=readline()

println("\n")
# Input max primarykey length
function fcolormaxvalue()
    for color in [:cyan]
printstyled("WHAT MAX. NUMBER OF DIGITS SHOULD EACH FACTOR HAVE?";color = color)
println("\n")
    end
end
fcolormaxvalue()

maxlen=readline()

# Input max secondarykey length
println("                 ")
println("SECONDARY KEY: please indicate the desired length.")
println("\n")
function fcolorskey()
    for color in [:cyan]
printstyled("HOW MANY RANDOM LEADING BITS SHOULD THE CIPHER TEXT HAVE?\n";color = color)
    end
end
fcolorskey()
println("\n")
skeymaxlen=readline()

# Checking factorsnumb
function ffactorsnumbvalid()
	try
        parse(BigInt,factorsnumb,base=10)
    catch err
        if isa(err, ArgumentError)
            println("Factors number MUST be a decimal integer!")
            sleep(10)
            exit()						 
        end
	end
end	
factorsnumbdec=ffactorsnumbvalid()

# Checking minlen
function fminlenvalid()
	try
        parse(BigInt,minlen,base=10)
    catch err
        if isa(err, ArgumentError)
            println("Minlen MUST be a decimal integer!")
            sleep(10)
            exit()						 
        end
	end
end	
mindec=fminlenvalid()

# Checking maxlen
function fmaxlenvalid()
	try
        parse(BigInt,maxlen,base=10)
    catch err
        if isa(err, ArgumentError)
            println("Maxlen MUST be a decimal integer!")
            sleep(10)
            exit()						 
        end
	end
end	
maxdec=fmaxlenvalid()

# Checking secondaryupperlimit
# function fsecondaryupperlimitvalid()
#	try
#        parse(BigInt,skeymaxlen,base=10)
#    catch err
#        if isa(err, ArgumentError)
#            println("Maxlen MUST be a decimal integer!")
#            sleep(10)
#            exit()						 
#        end
#	end
#end	
#secmax=fsecondaryupperlimitvalid()

#########################################
# Primary Key Random Integer Generation #
#########################################

i = 1
pkey = 1

# pkeybin = string(pkey,base=2)


while i <= factorsnumbdec

    function frand1()
        try
           @time rand(mindec:maxdec)
    	catch err
            if isa(err, ArgumentError)
                println("Minlen MUST be less than Maxlen!")
                sleep(10)
                exit()						 
            end
	    end   
    end

    # Random integer generated by frand function
    frandvalue1=frand1()	
    println("frandvalue1: ", frandvalue1)

    #########################
    # Next Prime Generation #
    #########################
	upperlimit = 10 ^ frandvalue1
	
	    function frand2()
        try
           @time rand(200:upperlimit)
    	catch err
            if isa(err, ArgumentError)
                println("Minlen MUST be less than Maxlen!")
                sleep(10)
                exit()						 
            end
	    end   
    end

    # Random integer generated by frand function
    frandvalue2=frand2()	
    println("Frandvalue 2: ", frandvalue2)

    function fnextprime()
        @time nextprime(frandvalue2)
    end
    factor=fnextprime()
	println("Factor: ",factor)

    function fcheckmax()
        if factor > maxdec
    	    println("Attention! The prime number exceeds the range.")
       end
    end
    fcheckmax()
	
    factorbin=string(factor,base=2)
	println("Factorbin: ",factorbin)
	
	global pkey = pkey * factor
	println("pkey: ",pkey)
	
	global pkeybin = string(pkey,base=2)

    println("Factor number : ", i)
    global i += 1

	
end

# pkeybase64 = String(base64encode(pkeybin))

function fwritetofile1()
    open("../../../../4_PRIMARY_KEY/primarykey.txt", "w") do f
                 write(f, pkeybin)
    end
end
fwritetofile1()
println("Primary key has been generated and updated in 'primarykey.txt'.")		
		
skeymaxlendec=parse(BigInt,skeymaxlen)
		
    function frand3()
        try
           @time rand(1:skeymaxlendec)
    	catch err
            if isa(err, ArgumentError)
                println("Skey max length MUST be less than 1!")
                sleep(10)
                exit()						 
            end
	    end   
    end

    # Random integer generated by frand function
    frandvalue3=frand3()	
    println("Frandvalue 3: ", frandvalue3)

skeystring = string(frandvalue3)
	
function fwritetofile2()
    open("../../../../5_SECONDARY_KEY/secondarykey.txt", "w") do f
                 write(f, skeystring)
    end
end
fwritetofile2()
println("Secondary key has been generated and updated in 'secondarykey.txt'.")		
		

println(" ")
println("----------------- ")
println("Primary Key Generation Report")
println("----------------- ")
println("Primary Key Base  2: ", pkeybin)
println("----------------- ")










