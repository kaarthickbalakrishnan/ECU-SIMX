'''
Created on 02-June-2020
Reference: https://github.com/ebroecker/canmatrix.git

Supporting Formats
Importing: ['arxml', 'dbc', 'dbf', 'json', 'kcd', 'sym', 'xls', 'xlsx', 'yaml']
Exporting: ['arxml', 'csv', 'dbc', 'dbf', 'json', 'kcd', 'xml', 'sym', 'xls', 'xlsx', 'yaml', 'py', 'lua']


@author: manzoor
'''

import os

import canmatrix.convert

def run_tests():
    
    input_file_base = 'test'
    input_file_format = 'xlsx'.lower()
    output_file_base = input_file_base
    output_file_format = 'dbc'.lower()
      
    in_file = input_file_base + '.' + input_file_format
    out_file = os.path.basename(output_file_base)
    out_file += '.' + output_file_format
    
    output_directory = 'converted'
# un-comment the below snippet if needs to delete all previous output files
#import shutil
#     try:
#         shutil.rmtree(converted_path)
#     except OSError:
#         # it's already not there...
#         pass
    
    try:
        os.makedirs(output_directory)
    except OSError:
        # TODO: be more specific: OSError: [Errno 17] File exists:
        # 'converted'
        pass
    out_file = os.path.join(output_directory, out_file)
    canmatrix.convert.convert(in_file, out_file)

    print('\n Convertion completed')

if __name__ == "__main__":
    run_tests()
