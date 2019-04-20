import sys
import json

if __name__ == '__main__':

    f = open("StreamingAssets/Script/RobotConfig.json","r",encoding='utf-8') 
    fileJson = json.load(f)
    f.close()
    thread_count = fileJson["Config"]["thread_count"]
    robot_count_per_thread = fileJson["Config"]["robot_count_per_thread"]
    bContinued = fileJson["Config"]["bContinued"]