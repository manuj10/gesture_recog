// commandg.cpp : Defines the entry point for the console application.

#include "stdafx.h"
#include "windows.h"
#include "iostream"
#include "winuser.h"


int _tmain(int argc, _TCHAR* argv[])
{int vk,vk1;
HWND    hwndvlc = FindWindowA("QTool",NULL);
SetForegroundWindow(hwndvlc);
	switch(_ttoi(argv[1]))
		{case 1:vk=VkKeyScan(' ');
			keybd_event(vk,0,0,0);
			keybd_event(vk,0,KEYEVENTF_KEYUP,0);
			break;
		case 2:vk=VkKeyScan('s');
			keybd_event(vk,0,0,0);
			keybd_event(vk,0,KEYEVENTF_KEYUP,0);
			break;
		case 3:
			vk=VK_CONTROL;
			vk1=VK_UP;
			keybd_event(vk,0,0,0);
			keybd_event(vk1,0,0,0);
			keybd_event(vk1,0,KEYEVENTF_KEYUP,0);
			keybd_event(vk,0,KEYEVENTF_KEYUP,0);
			break;
		case 4:vk=VK_CONTROL;
			   vk1=VK_DOWN;
			keybd_event(vk,0,0,0);
			keybd_event(vk1,0,0,0);
			keybd_event(vk1,0,KEYEVENTF_KEYUP,0);
			keybd_event(vk,0,KEYEVENTF_KEYUP,0);
			break;
        case 5:vk=VkKeyScan('c');
			keybd_event(vk,0,0,0);
			keybd_event(vk,0,KEYEVENTF_KEYUP,0);
			break;
		default:
				return 0;
	}
return 0;}

