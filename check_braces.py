
import sys
import re

def check_braces(filename):
    with open(filename, 'r', encoding='utf-8') as f:
        lines = f.readlines()

    stack = []
    
    # Regex to find braces and strings/comments
    # Simplified parser: remove strings and comments first?
    # Simple state machine is better
    
    line_no = 0
    in_block_comment = False
    
    for line in lines:
        line_no += 1
        i = 0
        while i < len(line):
            char = line[i]
            
            # Skip comments and strings
            if in_block_comment:
                if line[i:i+2] == '*/':
                    in_block_comment = False
                    i += 1
                i += 1
                continue
                
            if line[i:i+2] == '//':
                break # line comment
                
            if line[i:i+2] == '/*':
                in_block_comment = True
                i += 2
                continue
                
            if char in "\"'":
                # String literal, skip until closing quote
                quote = char
                i += 1
                while i < len(line):
                    if line[i] == quote and (i == 0 or line[i-1] != '\\'):
                        break
                    i += 1
                if i >= len(line):
                    # Multiline string or broken string?
                    # Dart supports multiline strings, but let's assume simple for now
                    pass 
                i += 1
                continue
            
            if char in '({[':
                stack.append((char, line_no, i + 1))
            elif char in ')}]':
                if not stack:
                    print(f"Error: Unmatched '{char}' at Line {line_no}:{i+1}")
                    return
                last, last_line, last_col = stack.pop()
                expected = {'(': ')', '{': '}', '[': ']'}[last]
                if char != expected:
                    print(f"Error: Mismatched '{char}' at Line {line_no}:{i+1}. Expected '{expected}' (from Line {last_line}:{last_col})")
                    return
            
            i += 1

    if stack:
        last, last_line, last_col = stack[-1]
        print(f"Error: Unclosed '{last}' at Line {last_line}:{last_col}")
    else:
        print("Braces are balanced.")

if __name__ == "__main__":
    check_braces(sys.argv[1])
