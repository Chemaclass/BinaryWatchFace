using Toybox.Graphics;
using Toybox.Lang;
using Toybox.System;
using Toybox.WatchUi;
using Toybox.Time;
using Toybox.Time.Gregorian;

class BinaryWatchFaceView extends WatchUi.WatchFace
{
    private var _binaryRenderer as BinaryRenderer;

    private var _app as Application;
    private var _widthScreen as Int;
    private var _heightScreen as Int;

    function initialize() as Void
    {
        WatchFace.initialize();
        _binaryRenderer = new BinaryRenderer(6);
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void
    {
        setLayout(Rez.Layouts.WatchFace(dc));

        _app = Application.getApp();

        _widthScreen = dc.getWidth();
        _heightScreen = dc.getHeight();
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
        drawBinaryClock(dc, clockTime);
        
        if (_app.getProperty("ShouldDisplayDecimalTime")) {
            drawDecimalClock(dc, clockTime);
        }
    }

    private function drawDateLine(dc as Dc) as Void
    {
        var today = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
        var date = Lang.format("$1$, $2$ $3$ $4$", [
            today.day_of_week,
            today.day,
            today.month,
            today.year
        ]);
        
        dc.setColor(_app.getProperty("DateColor"), Graphics.COLOR_TRANSPARENT);
        dc.drawText(_widthScreen/2, 20, Graphics.FONT_MEDIUM, date, Graphics.TEXT_JUSTIFY_CENTER + Graphics.TEXT_JUSTIFY_VCENTER);
    }

    private function drawBinaryClock(dc as Dc, clockTime as ClockTime) as Void
    {
        dc.setColor(_app.getProperty("BinaryClockColor"), Graphics.COLOR_TRANSPARENT);

        drawBinary(dc, _heightScreen/2 - 55, _binaryRenderer.fromDecimal(clockTime.hour));
        drawBinary(dc, _heightScreen/2, _binaryRenderer.fromDecimal(clockTime.min));
        drawBinary(dc, _heightScreen/32 * 25, _binaryRenderer.fromDecimal(clockTime.sec));
    }

    private function drawBinary(dc as Dc, height as Int, time as String) as Void
    {
        dc.drawText(_widthScreen/2, height, Graphics.FONT_LARGE * 2, time, Graphics.TEXT_JUSTIFY_CENTER + Graphics.TEXT_JUSTIFY_VCENTER);
    }

    private function drawDecimalClock(dc as Dc, clockTime as ClockTime) as Void
    {
        var timeFormat = "$1$:$2$";
        var hours = clockTime.hour;
        if (!System.getDeviceSettings().is24Hour) {
            if (hours > 12) {
                hours = hours - 12;
            }
        } else if (Application.getApp().getProperty("UseMilitaryFormat")) {
            timeFormat = "$1$$2$";
            hours = hours.format("%02d");
        }
        
        dc.setColor(_app.getProperty("DecimalClockColor"), Graphics.COLOR_TRANSPARENT);

        drawDecimal(dc, _heightScreen/2 - 45, hours);
        drawDecimal(dc, _heightScreen/2 - 15, clockTime.min.format("%02d"));
        drawDecimal(dc, _heightScreen/2 + 15, clockTime.sec.format("%02d"));
    }

    private function drawDecimal(dc as Dc, height as Int, time as String) as Void 
    {
        dc.drawText(_widthScreen/2+115, height, Graphics.FONT_SMALL, time, Graphics.TEXT_JUSTIFY_RIGHT);
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
