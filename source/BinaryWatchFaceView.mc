using Toybox.Graphics;
using Toybox.Lang;
using Toybox.System;
using Toybox.WatchUi;
using Toybox.Time;
using Toybox.Time.Gregorian;

class BinaryWatchFaceView extends WatchUi.WatchFace
{
    private var _binaryRenderer as BinaryRenderer;

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
        drawDecimalClock(dc, clockTime);
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
        
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(_widthScreen/2, 20, Graphics.FONT_MEDIUM, date, Graphics.TEXT_JUSTIFY_CENTER + Graphics.TEXT_JUSTIFY_VCENTER);
    }

    private function drawBinaryClock(dc as Dc, clockTime as ClockTime) as Void
    {
        drawBinary(dc, _widthScreen/2, _heightScreen/2 - 55, _binaryRenderer.fromDecimal(clockTime.hour));
        drawBinary(dc, _widthScreen/2, _heightScreen/2, _binaryRenderer.fromDecimal(clockTime.min));
        drawBinary(dc, _widthScreen/2, _heightScreen/32 * 25, _binaryRenderer.fromDecimal(clockTime.sec));
    }

    private function drawDecimalClock(dc as Dc, clockTime as ClockTime) as Void
    {
        drawDecimal(dc, _widthScreen/2+115, _heightScreen/2 - 45, clockTime.hour.format("%02d"));
        drawDecimal(dc, _widthScreen/2+115, _heightScreen/2 - 15, clockTime.min.format("%02d"));
        drawDecimal(dc, _widthScreen/2+115, _heightScreen/2 + 15, clockTime.sec.format("%02d"));
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
