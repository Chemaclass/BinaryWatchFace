import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class BinaryWatchFaceView extends WatchUi.WatchFace {

    private var widthScreen as Int;
    private var heightScreen as Int;

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));

        widthScreen = dc.getWidth();
        heightScreen = dc.getHeight();
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

        var clockTime = System.getClockTime();

        drawHour(dc, clockTime);
        drawMin(dc, clockTime);
        drawSec(dc, clockTime);
    }
    
    private function drawHour(dc as Dc, clockTime as ClockTime) as Void {
        var binaryString = padLeftZeros(decToBinary(clockTime.hour), 6);
        
        drawBinary(dc, widthScreen/2, heightScreen/2 - 55, binaryString);
        drawDecimal(dc, widthScreen/2+115, heightScreen/2 - 50, clockTime.hour.format("%02d"));
    }

    private function drawMin(dc as Dc, clockTime as ClockTime) as Void {
        var binaryString = padLeftZeros(decToBinary(clockTime.min), 6);
        
        drawBinary(dc, widthScreen/2, heightScreen/2, binaryString);
        drawDecimal(dc, widthScreen/2+115, heightScreen/2 - 10, clockTime.min.format("%02d"));
    }

    private function drawSec(dc as Dc, clockTime as ClockTime) as Void {
        var binaryString = padLeftZeros(decToBinary(clockTime.sec), 6);

        drawBinary(dc, widthScreen/2, heightScreen/32 * 25, binaryString);
        drawDecimal(dc, widthScreen/2+115, heightScreen/2 + 30, clockTime.sec.format("%02d"));
    }

    private function drawBinary(dc, width, height, timeString as String) as Void {
        var font = Graphics.FONT_LARGE * 2;
        
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(width, height, font, timeString, Graphics.TEXT_JUSTIFY_CENTER + Graphics.TEXT_JUSTIFY_VCENTER);
    }

    private function drawDecimal(dc, width, height, timeString as String) as Void {
        var font = Graphics.FONT_LARGE;
        
        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.drawText(width, height, font, timeString, Graphics.TEXT_JUSTIFY_RIGHT);
    }

    private function decToBinary(n as Int) as String {
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

    private function padLeftZeros(inputString as String, length as Int) as String {
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
