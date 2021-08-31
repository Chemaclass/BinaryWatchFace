using Toybox.Graphics;
using Toybox.Lang;
using Toybox.System;
using Toybox.WatchUi;
using Toybox.Time;
using Toybox.Time.Gregorian;

class BinaryWatchFaceView extends WatchUi.WatchFace
{

	private const BINARY_ZEROS_LENGTH = 6;

    private var widthScreen as Int;
    private var heightScreen as Int;

    function initialize()
    {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void
    {
        setLayout(Rez.Layouts.WatchFace(dc));

        widthScreen = dc.getWidth();
        heightScreen = dc.getHeight();
    }

    // Called when this View is brought to the foreground.
    // Restore the state of this View and prepare it to be shown.
    // This includes loading resources into memory.
    function onShow() as Void
    {}

    // Update the view
    function onUpdate(dc as Dc) as Void
    {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);

        var clockTime = System.getClockTime();

        drawDateLine(dc);

        drawHourLine(dc, clockTime);
        drawMinutesLine(dc, clockTime);
        drawSecondsLine(dc, clockTime);
    }

    private function drawDateLine(dc as Dc) as Void
    {
		var today = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
		var dateString = Lang.format(
		    "$1$, $2$ $3$ $4$",
		    [
		        today.day_of_week,
		        today.day,
		        today.month,
		        today.year
		    ]
		);
		
		var font = Graphics.FONT_MEDIUM;
        
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(widthScreen/2, 20, font, dateString, Graphics.TEXT_JUSTIFY_CENTER + Graphics.TEXT_JUSTIFY_VCENTER);
    }

    private function drawHourLine(dc as Dc, clockTime as ClockTime) as Void
    {
        drawBinary(dc, widthScreen/2, heightScreen/2 - 55, padLeftZeros(decToBinary(clockTime.hour)));

        drawDecimal(dc, widthScreen/2+115, heightScreen/2 - 45, clockTime.hour.format("%02d"));
    }

    private function drawMinutesLine(dc as Dc, clockTime as ClockTime) as Void
    {
        drawBinary(dc, widthScreen/2, heightScreen/2, padLeftZeros(decToBinary(clockTime.min)));

        drawDecimal(dc, widthScreen/2+115, heightScreen/2 - 15, clockTime.min.format("%02d"));
    }

    private function drawSecondsLine(dc as Dc, clockTime as ClockTime) as Void
    {
        drawBinary(dc, widthScreen/2, heightScreen/32 * 25, padLeftZeros(decToBinary(clockTime.sec)));

        drawDecimal(dc, widthScreen/2+115, heightScreen/2 + 15, clockTime.sec.format("%02d"));
    }

    private function drawBinary(dc as Dc, width as Int, height as Int, time as String) as Void
    {
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(width, height, Graphics.FONT_LARGE * 2, time, Graphics.TEXT_JUSTIFY_CENTER + Graphics.TEXT_JUSTIFY_VCENTER);
    }

    private function drawDecimal(dc as Dc, width as Int, height as Int, time as String) as Void 
    {
        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.drawText(width, height, Graphics.FONT_SMALL, time, Graphics.TEXT_JUSTIFY_RIGHT);
    }

    private function decToBinary(n as Int) as String
    {
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

    private function padLeftZeros(inputString as String) as String
    {
        if (inputString.length() >= BINARY_ZEROS_LENGTH) {
            return inputString;
        }

        var sb = "";
        while (sb.length() < BINARY_ZEROS_LENGTH - inputString.length()) {
            sb += "0";
        }
        sb += inputString;
    
        return sb.toString();
    }

    // Called when this View is removed from the screen. 
    // Save the state of this View here. This includes 
    // freeing resources from memory.
    function onHide() as Void
    {}

    // The user has just looked at their watch. 
    // Timers and animations may be started here.
    function onExitSleep() as Void
    {}

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void
    {}
}
