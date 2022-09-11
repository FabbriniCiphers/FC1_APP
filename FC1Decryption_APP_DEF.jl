#
# FC1 APP based on FC1 Algorithm and coded by Michele Fabbrini in Julia Programming 
# Language is made available under the Creative Commons Attribution license.
# The following is a human-readable summary of (and not a substitute for) the full 
# legal text of the CC BY 4.0 license https://creativecommons.org/licenses/by/4.0/.
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

# FC1Decryption APP - Version 2.1.1-beta

using SHA 
using ZipFile
using DelimitedFiles

#################################
# Reset Decrypted text bin file #
#################################

function fresetfile()	  
		     open("decryptedplaintextbin.txt", "w") do f
                write(f, "")
             end
		 end
		 fresetfile()

#  function funzip()
#      r = ZipFile.Reader("ciphertext.zip")
#	  for f in r.files
#	     println("Filename: $(f.name)")
#	     write("ciphertext.txt", read(f, String))
#      end
#  close(r)
#  end
#  funzip()

###############
# WELCOME MSG #
###############

function fcolorlogo()
    for color in [:green]
printstyled("
########################

#######  #######      ##
##       ##         # ##
#####    ##        #  ##   Fabbrini Cipher 1 - DECRYPTION APP
##       ##           ##                       Version 2.1.1-beta
##       #######      ##                       fabbrini.org
		 
########################\n"; color = color)
    end
end
fcolorlogo()

println("\n")
println("Welcome to the FC1 algorithm decryption application!")
println("\n")
function fcolorinitwarn()
    for color in [:yellow]
printstyled("##########################################################\n
THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,\n
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,\n
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.\n
##########################################################\n";color = color)
println("\n")

    end
end
fcolorinitwarn()

function fcolorcheck()
    for color in [:cyan]
printstyled("Check that 'cyphertext.fc1enc', 'primarykey.txt' and 'secondarykey.txt' are stored in the relative folders,\n
then press '1' to start to decrypt, or any other key to exit.";color = color)
    end
end
fcolorcheck()

println("\n")
println("Your choice is...?\n")
check = readline()
println("\n")

function fcheck()
    if check == "1"
	    println("You chose 1.")
    else println("You chose to quit, please wait...")
	     sleep(5)
	     exit()		
	end
end
fcheck()
println("Decrypting data...")

####################
# Input Validation #
####################

# Opening ciphertext.txt
#ciphertext.txt existence check
function fcipherexist()
     try 
        global cipher=open(f->read(f, String), "../../../../2_CIPHER_TEXT/ciphertext.fc1enc")
     catch err
         if isa(err, SystemError) 
            	println("\n")
		        function fcolorcipherexist()
                    for color in [:yellow]
		            printstyled("WARNING: no 'ciphertext.txt' file found in '2_CIPHER_TEXT'";color = color)
		         sleep(10)
		         exit()
				    end
				end
				fcolorcipherexist()
		end
     end
end 
fcipherexist()

# Opening primarykey.txt
#primarykey.txt existence check
function fprimaryexist()
     try 
        global pkeybin=open(f->read(f, String), "../../../../4_PRIMARY_KEY/primarykey.txt")
     catch err
         if isa(err, SystemError) 
            	println("\n")
		        function fcolorprimaryexist()
                    for color in [:yellow]
		            printstyled("WARNING: no 'primarykey.txt' file found in '4_PRIMARY_KEY'";color = color)
		         sleep(10)
		         exit()
				    end
				end
				fcolorprimaryexist()
		end
     end
end 
fprimaryexist()

# Opening secondarykey.txt
#secondarykey.txt existence check
function fsecondaryexist()
     try 
        global skeystring=open(f->read(f, String), "../../../../5_SECONDARY_KEY/secondarykey.txt")
     catch err
         if isa(err, SystemError) 
            	println("\n")
		        function fcolorsecondaryexist()
                    for color in [:yellow]
		            printstyled("WARNING: no 'secondarykey.txt' file found in '5_SECONDARY_KEY'";color = color)
		         sleep(10)
		         exit()
				    end
				end
				fcolorsecondaryexist()
		end
     end
end 
fsecondaryexist()

#Checking plaintext
function fplainvalid()
	try
        parse(BigInt,plain,base=2)
    catch err
        if isa(err, ArgumentError)
            println("The plaintextbits MUST be a binary string!")
            sleep(10)
            exit()						 
        end
	end
end	
fplainvalid()

#Checking primarykey
function fpkeyvalid1()
    try
	    parse(BigInt,plain,base=2)
    catch err
        if isa(err, ArgumentError)
            println("The Primary Key bin MUST be a binary string!")
            sleep(10)
            exit()						 
        end
	end
end
fpkeyvalid1()

function fpkeyvalid2()
    if startswith(pkeybin, "0")
	    println("The Primary Key CANNOT start with '0'!")
		sleep(10)
        exit()		
	end
end
fpkeyvalid2()

#Checking secondarykey
function fskeyvalid()
    try
       parse(BigInt,skeystring,base=10)
    catch err
        if isa(err, ArgumentError)
            println("The Secondary Key MUST be an integer!")
            sleep(10)
            exit()
		end
	end
end							
fskeyvalid()

##############
# Sys. Init. #
##############

skey=parse(Int64,skeystring)
clen=length(cipher) 
remclen=clen-skey
remc=last(cipher,remclen)
pkeybinlen=length(pkeybin)
tplain=""

####################
# Decryption Start #
####################

function fdecrypt()

    # Case1
    if remclen >= pkeybinlen
        cblock=first(remc,pkeybinlen)
		inputbin=lstrip(cblock,['0'])		 
        input=parse(BigInt,inputbin,base=2)
        pkey=parse(BigInt,pkeybin,base=2)
         
        function finv(input,pkey)
		    try
                    invmod(input,pkey) #deleted @time to save time
			catch err
                if isa(err, DomainError)
                    println("INTEGRITY ALERT: THE CIPHERTEXT COULD BE CORRUPTED!")
                    sleep(10)
					exit()
			    end
            end
        end   	
        output=finv(input,pkey)        
        outputbin=string(output,base=2)       
        tplain1=chop(outputbin, head = 1, tail = 1)        
		global remclen=remclen-pkeybinlen        
        global remc=last(remc,remclen)        
		global tplain=string(tplain,tplain1)
		
		###################
	    function fappendtofile()
     
        io = open("decryptedplaintextbin.txt", "a")
        write(io, tplain)
	#	println(tplain)
		tplain = ""
		close(io)
		end
      
        fappendtofile()
		###################
		
	    fdecrypt()


    # Case 2
    elseif remclen < pkeybinlen
	
	    tplain=open(f->read(f, String), "decryptedplaintextbin.txt")
        
	
		global tplainlen=length(tplain)
		global plainlen=tplainlen-256
	    plaincheck=first(tplain,plainlen)
		      				
########################
# Data Integrity Check #
########################

	    tagcheck=last(tplain,256) 
        taghex= bytes2hex(sha256(plaincheck))
      # println("This is the 256-bit hash of Plaintext check (hex): ", taghex)
        tagdec=parse(BigInt,taghex,base=16)       
        tagbintemp=string(tagdec,base=2)
        tagbintemplen = length(tagbintemp)
		global ikeylen=remclen

        function ftagbitscheck()
            if tagbintemplen == 256
                global tagbin = tagbintemp
            else
                global tagbin = lpad(tagbintemp,256,"0")
            end          
		end
		ftagbitscheck()
		 
		function fintegritycheck()
		    check=cmp(tagcheck::AbstractString, tagbin::AbstractString)
                  if check==0
				  #    function fwritetofile()
		          #        open("decryptedplaintextbin.txt", "w") do f
                  #             write(f, plaincheck)
                  #        end
	              #    end
				  #	  fwritetofile()	
	
					  println("Preparing final output...")
					  include("RevConv.jl")
					  println("\n")
                      println("The Decrypted Plaintext has been generated and updated in '3_DECRYPTED_PLAIN_TEXT'.")
					  println("\n")
println("##############
# SUCCESS!!! #
##############\n")
		          else
				      println("\n")
					  function fcoloralert()
                          for color in [:red]
                             printstyled("DATA INTEGRITY ALERT: CORRUPTED CIPHERTEXT!\n";color = color)
                          end
                      end
                      fcoloralert()
					  println("\n")
                  end 
         end
		 fintegritycheck()
    end
end

fdecrypt()

println("----------------- ")
function fcolorreport()
    for color in [:green]
printstyled("Decryption Report\n";color = color)
    end
end
fcolorreport()
println("----------------- ")
println("Primary Key Length (bits): ", pkeybinlen)
# println("Secondary Key (integer): ", skey)
println("Inferred Key Length (bits): ", ikeylen)
println("Tagged Plaintext Length (bits): ", tplainlen)
println("Decrypted Plaintext Length (bits): ", plainlen)
println("Ciphertext Length (bits): ", clen)
println("\n")
println("Exit in 7 secs...")


sleep(7)





