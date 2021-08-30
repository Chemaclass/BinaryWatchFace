import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

using Toybox.Graphics;

class BinaryWatchFaceView extends WatchUi.WatchFace {

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);

        var widthScreen = dc.getWidth();
        var heightScreen = dc.getHeight();

        var clockTime = System.getClockTime();
        var font = Graphics.FONT_LARGE * 2;

        var timeHourString = padLeftZeros(decToBinary(clockTime.hour), 6);
        var timeMinString  = padLeftZeros(decToBinary(clockTime.min),  6);
        var timeSecString  = padLeftZeros(decToBinary(clockTime.sec),  6);

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(widthScreen/2, (heightScreen/2)-55, font, timeHourString, Graphics.TEXT_JUSTIFY_CENTER + Graphics.TEXT_JUSTIFY_VCENTER);
        dc.drawText(widthScreen/2, (heightScreen/2), font, timeMinString, Graphics.TEXT_JUSTIFY_CENTER + Graphics.TEXT_JUSTIFY_VCENTER);
        dc.drawText(widthScreen/2, (heightScreen/32)*25, font, timeSecString, Graphics.TEXT_JUSTIFY_CENTER + Graphics.TEXT_JUSTIFY_VCENTER);
        
        System.println("hour in binary is: " + clockTime.hour.format("%02d"));
        System.println("min in binary is: " + clockTime.min.format("%02d"));
        System.println("sec in binary is: " + clockTime.sec.format("%02d"));
        System.println("------------------------");        
    }

    function decToBinary(n as Int) as String {
        var binaryNum = new Int[32];
        var i = 0;
        while (n > 0) {
            binaryNum[i] = n % 2;
            n = n / 2;
            i++;
        }
 
        var result = "";
        for (var j = i - 1; j >= 0; j--) {
            result += binaryNum[j];
        }
        
        return result;
    }
    
    function padLeftZeros(inputString as String, length as Int) as String {
	    if (inputString.length() >= length) {
	        return inputString;
	    }
	    var sb = "";
	    while (sb.length() < length - inputString.length()) {
	        sb += "0";
	    }
	    sb += inputString;
	
	    return sb.toString();
	}

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
    }

}
