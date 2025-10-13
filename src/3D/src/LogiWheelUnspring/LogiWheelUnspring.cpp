// LogiWheelUnspring.cpp : Defines the entry point for the console application.
//


//#include <windows.h>
#include <iostream>

#include "LogiControllerInput.h"
#include "LogiControllerProperties.h"
#include "LogiWheel.h"

using namespace LogitechControllerInput;
using namespace LogitechSteeringWheel;

int _tmain(int argc, _TCHAR* argv[])
{
	// Get the HWND
	HWND hwndC = GetConsoleWindow() ; 

	// Then we could just get the HINSTANCE:
	HINSTANCE hInstC = GetModuleHandle( 0 ) ;

    ControllerInput* g_controllerInput = new ControllerInput(hwndC, TRUE);
    Wheel* g_wheel = new Wheel(g_controllerInput);

    ControllerPropertiesData propertiesData;
    ZeroMemory(&propertiesData, sizeof(propertiesData));
    propertiesData.forceEnable = FALSE;
    propertiesData.overallGain = 0;
    propertiesData.springGain = 0;
    propertiesData.damperGain = 0;
    propertiesData.combinePedals = FALSE;
    propertiesData.wheelRange = 900;
	propertiesData.defaultSpringEnabled = FALSE;
	propertiesData.defaultSpringGain = 0;

	HRESULT result;

    for (int index_ = 0; index_ < LogitechSteeringWheel::LG_MAX_CONTROLLERS; index_++)
    {
        if (g_wheel->IsConnected(index_))
        {
		    if (g_wheel->IsConnected(index_, LG_MANUFACTURER_LOGITECH) && g_wheel->IsConnected(index_, LG_DEVICE_TYPE_WHEEL))
            {
std::cout<<"Index: "<<index_<<" connected. Set the wheel!"<<std::endl;
				result = g_wheel->SetPreferredControllerProperties(propertiesData);
				g_controllerInput->Update();
				g_wheel->Update();
std::cout<<"Setting Controller Properties: Index "<<index_<<" = ";
result == S_OK? (std::cout<<"SUCCESSFUL!"<<std::endl):(std::cout<<"FAILED!"<<std::endl);
				result = g_wheel->PlayCarAirborne(index_);
				g_controllerInput->Update();
				g_wheel->Update();
std::cout<<"Play Airborne: Index "<<index_<<" = ";
result == S_OK? (std::cout<<"SUCCESSFUL!"<<std::endl):(std::cout<<"FAILED!"<<std::endl);
				result = g_wheel->PlayConstantForce(index_, 0);
				g_controllerInput->Update();
				g_wheel->Update();
std::cout<<"Play Constant Force: Index "<<index_<<" = ";
result == S_OK? (std::cout<<"SUCCESSFUL!"<<std::endl):(std::cout<<"FAILED!"<<std::endl);
			}
		}
	}

	delete g_wheel;
	delete g_controllerInput;

	return 0;
}

