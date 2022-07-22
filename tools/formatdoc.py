# coding=utf-8
'''
@Author: King
@Date: 2022-07-22 星期五 19-22-59
@Email: linsy_king@sjtu.edu.cn
@Url: http://www.yydbxx.cn
'''


import os
import re
import sys

mypath = sys.argv[1]

gg = os.walk(mypath)

if len(sys.argv) > 2:
    para = sys.argv[2]
    if para != "--validate":
        print("Unknown parameter")
        exit(-1)
    for p, _, fp in gg:
        for f in fp:
            path = os.path.join(p, f)

            with open(path, 'r') as f:
                content = f.read()

            if content.find("@docs") == -1:
                print(f"Please check {path}, there is no docs!")
                exit(-1)
            firstline = content.split("\n")[0]
            if firstline.find(" (..)") != -1:
                print(f"Please check {path}, you cannot use (..)!")
                exit(-1)
    print("Validate Success")
    exit(0)


for p, _, fp in gg:
    for f in fp:
        path = os.path.join(p, f)

        with open(path, 'r') as f:
            content = f.read()

        if content.find("@docs") != -1:
            continue

        rec = r'\ntype ([^ ]*)\n'
        recc = re.compile(rec)
        rer = re.findall(recc, content)

        rec2 = r'\ntype alias ([^ ]*) '
        recc2 = re.compile(rec2)
        rer2 = re.findall(recc2, content)

        rec3 = r'\n([^ \n]*) :'
        recc3 = re.compile(rec3)
        rer3 = re.findall(recc3, content)

        alls = rer + rer2 + rer3

        headinfo = '''{-| This is the doc for this module
        '''

        for i in alls:
            headinfo += f"\n@docs {i}\n"

        headinfo += "\n-}\n"

        # print(headinfo)

        rep = re.sub(rec, '\n{-| ' + r'\1' + '\n-}'+r'\ntype \1\n', content)
        rep2 = re.sub(rec2, '\n{-| ' + r'\1' + '\n-}'+r'\ntype alias \1 ', rep)
        rep3 = re.sub(rec3, '\n{-| ' + r'\1' + '\n-}'+r'\n\1 :', rep2)

        # print(rep3)

        replines = rep3.split("\n")
        replines.insert(2, headinfo)
        replines = "\n".join(replines)

        with open(path, 'w') as f:
            f.write(replines)


# Expose!

gg = os.walk(mypath)
for p, _, fp in gg:
    for f in fp:
        path = os.path.join(p, f)

        with open(path, 'r') as f:
            content = f.read()
        firstline = content.split("\n")[0]
        if firstline.find(" (..)") == -1:
            continue
        rec = r'\ntype ([^ ]*)\n'
        recc = re.compile(rec)
        rer = re.findall(recc, content)

        rec2 = r'\ntype alias ([^ ]*) '
        recc2 = re.compile(rec2)
        rer2 = re.findall(recc2, content)

        rec3 = r'\n([^ \n]*) :'
        recc3 = re.compile(rec3)
        rer3 = re.findall(recc3, content)

        alls = rer2 + rer3

        heads = ""
        for i in rer:
            heads += f"{i}(..), "
        for i in alls:
            heads += f"{i}, "

        repfirstline = firstline.replace("..", heads[:-2])
        repcontent = content.replace(firstline, repfirstline)
        with open(path, 'w') as f:
            f.write(repcontent)
