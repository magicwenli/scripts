# QBittorrent Backup 
# Version 0.1
# By magicwenli

import os,datetime,logging,shutil

maxBackups=15
appdata=os.getenv("APPDATA")+"\\qBittorrent"
localAppdata=os.getenv("LOCALAPPDATA")+"\\qBittorrent"

LOG_FORMAT = "%(asctime)s - %(levelname)s - %(message)s"
currPath = os.path.dirname(os.path.realpath(__file__))
backupPath = os.path.join(os.path.dirname(os.path.realpath(__file__)),"backups")
logPath = currPath + "\\backup.log"
logging.basicConfig(filename=logPath,filemode='a',level=logging.INFO,format=LOG_FORMAT)

target=datetime.datetime.now().strftime('%Y%m%d_%H%M%S')

def checkConfig():
    flag=True
    if not os.path.exists(appdata):
        flag=False
    if not os.path.exists(localAppdata):
        flag=False
    if not os.path.exists(backupPath):
        os.mkdir(backupPath)
    if flag:
        logging.info("检查Qbittorrent配置...配置文件存在")
    else:
        logging.warning("检查Qbittorrent配置...配置文件不存在")
    return flag

def backup():
    dest = os.path.join(backupPath,target)
    destLocal=os.path.join(dest,"Local\\qBittorrent")
    destRoaming=os.path.join(dest,"Roaming\\qBittorrent")
    os.mkdir(dest)
    try:
        logging.info("开始备份文件")
        shutil.copytree(appdata,destRoaming)
        shutil.copytree(localAppdata,destLocal)
    except IOError as e:
        logging.warning("无法复制目标文件夹")
    except :
        logging.warning("复制出错")

def mtime(dirName):
    dirpath=os.path.join(backupPath,dirName)
    mtime=os.path.getmtime(dirpath)
    return mtime

def delEarliest():
    backupFolders=os.listdir(backupPath)
    items=sorted(backupFolders,key=lambda x: mtime(x),reverse=True)
    # print(items)
    logging.info("当前最大备份数："+str(maxBackups))
    while len(items)>maxBackups:
        logging.warning("正在删除备份，名称："+items[-1])
        dirpath=os.path.join(backupPath,items[-1])
        shutil.rmtree(dirpath)


    

if __name__== "__main__":
    if not checkConfig():
        logging.warning("任务异常退出")
        exit(1)
    backup()
    delEarliest()
    logging.info("备份完成")
    exit(0)
    
