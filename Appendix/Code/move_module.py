# Python Module

import os     # Read filepaths
import shutil # Move files

def move(file_name='(file_name missing/)', src='(src missing/)', dst='(dst missing/)', print_out=True):
    """Moves files and writes what happens if print_out=True"""
    # append '/' if missing
    if not src[-1] == '/':
        src = src + '/'
    if not dst[-1] == '/':
        dst = dst + '/'

    # test if file and folders are specified correctly
    file_in_src   = os.path.isfile(src+file_name)
    dst_is_folder = os.path.isdir(dst)
    src_is_folder = os.path.isdir(src)

    # file, src, dst has to be valid
    if file_in_src and src_is_folder and dst_is_folder:
        if print_out:
            print('Moving: %s\n- From src: %s\n- Into dst: %s' % (file_name, src, dst))

        # print if overwriting
        if os.path.isfile(dst+file_name) and print_out:
            print('\n- Overwriting: [%s] in dst' % (file_name))

        # Moving file
        shutil.move(src+file_name, dst+file_name)

        # Display after movement
        if print_out:
            print('\nAfter\n- Files in src: %s\n- Files in dst: %s' % ( (os.listdir(src)) , (os.listdir(dst)) ))
    else:
        print('Error - Info below for fixing\n\nMove() callend from: [%s]\n' % (os.getcwd()))
        # Describe how the imputs are wrong
        print('Arguments to function are: file_name, src, dst')
        if not file_in_src and src_is_folder:
            print('- No file: [%s] located in src: [%s]' % (file_name, src))
            # show what is in src
            if src_is_folder:
                print("   Files in src %s\n" % (os.listdir(src)))
        # show what folders are valid
        if not src_is_folder:
            print('- Not valid src-folder: [%s]' % (src))
        if not dst_is_folder:
            print('- Not valid dst-folder: [%s]' % (dst))