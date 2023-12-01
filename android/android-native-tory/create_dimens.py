# -*- coding: utf-8 -*-

import os
import sys
import xml.etree.ElementTree as ET
from xml.etree.ElementTree import Element, SubElement, ElementTree

def _pretty_print(current, parent=None, index=-1, depth=0):
    for i, node in enumerate(current):
        _pretty_print(node, current, i, depth + 1)
    if parent is not None:
        if index == 0:
            parent.text = '\n' + ('\t' * depth)
        else:
            parent[index - 1].tail = '\n' + ('\t' * depth)
        if index == len(parent) - 1:
            current.tail = '\n' + ('\t' * (depth - 1))

currentPath = os.path.abspath(__file__)
supportedDpList = [360, 375, 390, 411]                                                     # 지원할 DP 리스트
fixedFile = os.path.dirname(currentPath) + "/app/src/main/res/values-sw375dp/dimens.xml"   # 원본 파일 경로, "" - 사용자 입력
fixedDp = 375                                                                              # 원본 DP, 0 - 사용자 입력

# Step 1. 사용자 입력
# Step 1-1. 원본 파일 경로
filePath = fixedFile

if filePath == "":
    filePath = raw_input("원본 dimens.xml 파일 경로를 입력하세요: ")

# 파일 유효성 체크
if not os.path.exists(filePath) and not os.path.isfile(filePath):
    print("유효하지 않은 파일입니다. 경로를 확인해주세요.")
    sys.exit()

# Step 1-2. 원본 DP
inputDp = fixedDp

if inputDp == 0:
    inputDp = int(raw_input("원본 DP를 입력하세요: "))

# DP 유효성 체크
if inputDp not in supportedDpList:
    print("지원하지 않는 DP입니다.")
    sys.exit()

# 입력한 DP는 리스트에서 삭제
supportedDpList.remove(inputDp)

# Step 2. 파일 읽기
f = open(filePath, 'r')
# 라인 출력
# lines = f.readlines()
# for line in lines:
#     print(line)

# 전체 출력
# data = f.read()
# print(data)

f.close()

# Step 3. XML 파싱
originRoot = ET.parse(filePath).getroot()

for supportedDp in supportedDpList:
    print("=======> " + str(supportedDp) + "dp 파일 생성 시작")
    ratio = float(supportedDp) / float(inputDp)
    root = Element(originRoot.tag)

    for originElement in originRoot:
        # origin 출력 테스트
        # print(originElement.tag, originElement.get("name"), originElement.text)
        element = Element(originElement.tag)
        element.set("name", originElement.get("name"))

        # 값이 dp인지 체크, @dimen 필터링
        value = originElement.text.replace("dp", "")

        if not value.isdigit():
            element.text = originElement.text
        else:
            newValue = round(float(value) * ratio, 2)
            element.text = str(newValue) + "dp"
        
        # print(element.tag, element.get("name"), element.text)
        root.append(element)

    # DP 폴더별로 파일 생성
    _pretty_print(root)
    tree = ElementTree(root)

    newFileDir = os.path.dirname(os.path.dirname(filePath)) + "/values-sw" + str(supportedDp) + "dp/"
    newFilePath = newFileDir + "dimens.xml"
    print("경로: " + newFilePath)

    if not os.path.exists(newFileDir):
        os.makedirs(newFileDir)

    with open(newFilePath, "wb") as file:
        tree.write(file, encoding='utf-8', xml_declaration=True)

    print("=======> " + str(supportedDp) + "dp 파일 생성 완료")


