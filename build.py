import os
import sys
import subprocess
import tarfile
import shutil

def main():
      
    current_script_path = __file__
    dso_directory = os.path.dirname(os.path.abspath(current_script_path))
                              
    ## Compile dso   
    print("[dso][build.py] Compiling DSO (output disabled) ... ")             
    source_folder = dso_directory
    build_folder = os.path.join(source_folder,"build")
    bin_folder = os.path.join(source_folder,"bin") 
    lib_folder = os.path.join(source_folder,"lib")
    
    if os.path.isdir(build_folder): 
        shutil.rmtree(build_folder)  
    if os.path.isdir(bin_folder): 
        shutil.rmtree(bin_folder)  
    if os.path.isdir(lib_folder): 
        shutil.rmtree(lib_folder)          
    if not os.path.isdir(build_folder): 
        subprocess.run(["mkdir",build_folder])   
   
    subprocess.run(["cmake", "-G", "Ninja","-B", build_folder,"-S",os.path.join(source_folder),"-DCMAKE_PREFIX_PATH=" + source_folder,"-DCMAKE_INSTALL_PREFIX=" + source_folder], capture_output=True, text=True)   
    subprocess.run(["cmake","--build", build_folder, "--config Release"], capture_output=True, text=True)
    #subprocess.run(["ninja","install","-C", build_folder]) 

if __name__ == "__main__":
    main()                
