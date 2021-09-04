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
        if (_app.getProperty("ShouldDisplayBattery")) {
            drawBattery(dc);
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
        var width = _widthScreen/2;
        var font = Graphics.FONT_LARGE * 2;
        var justification = Graphics.TEXT_JUSTIFY_CENTER + Graphics.TEXT_JUSTIFY_VCENTER;

        dc.setColor(_app.getProperty("BinaryClockColor"), Graphics.COLOR_TRANSPARENT);
        dc.drawText(width, _heightScreen/2 - 55, font, _binaryRenderer.fromDecimal(clockTime.hour), justification);
        dc.drawText(width, _heightScreen/2, font, _binaryRenderer.fromDecimal(clockTime.min), justification);
        dc.drawText(width, _heightScreen/32 * 25, font, _binaryRenderer.fromDecimal(clockTime.sec), justification);
    }

    private function drawDecimalClock(dc as Dc, clockTime as ClockTime) as Void
    {
        var width = _widthScreen/2 + 115;
        var font = Graphics.FONT_SMALL;
        var justification = Graphics.TEXT_JUSTIFY_RIGHT;

		dc.setColor(_app.getProperty("DecimalClockColor"), Graphics.COLOR_TRANSPARENT);
        dc.drawText(width, _heightScreen/2 - 45, font, clockTime.hour.format("%02d"), justification);
        dc.drawText(width, _heightScreen/2 - 15, font, clockTime.min.format("%02d"), justification);
        dc.drawText(width, _heightScreen/2 + 15, font, clockTime.sec.format("%02d"), justification);
    }

    private function drawBattery(dc as Dc) as Void
    {
        var stats = System.getSystemStats();

		var text = Math.round(stats.battery).format("%d")+ "%";
        var font = Graphics.FONT_SMALL;
        var justification = Graphics.TEXT_JUSTIFY_RIGHT;

        dc.setColor(_app.getProperty("BatteryColor"), Graphics.COLOR_TRANSPARENT);
        dc.drawText(_widthScreen, _heightScreen - 30, font, text, justification);
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
