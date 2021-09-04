using Toybox.Graphics;
using Toybox.Lang;
using Toybox.System;
using Toybox.WatchUi;
using Toybox.Time;
using Toybox.Time.Gregorian;

class BinaryWatchFaceView extends WatchUi.WatchFace
{
	private var _dateLineDrawer as DateLineDrawer;
	private var _binaryClockDrawer as BinaryClockDrawer;
	private var _decimalClockDrawer as DecimalClockDrawer;
	private var _stepsDrawer as StepsDrawer;
	private var _batteryDrawer as BatteryDrawer;

    function initialize() as Void
    {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void
    {
        setLayout(Rez.Layouts.WatchFace(dc));

        var app = Application.getApp();
        var width = dc.getWidth();
        var height = dc.getHeight();
        
        _dateLineDrawer = new DateLineDrawer(app, width, height);
        _binaryClockDrawer = new BinaryClockDrawer(app, width, height);
        _decimalClockDrawer = new DecimalClockDrawer(app, width, height);
        _stepsDrawer = new StepsDrawer(app, width, height);
        _batteryDrawer = new BatteryDrawer(app, width, height);
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
        _dateLineDrawer.draw(dc);
        _binaryClockDrawer.draw(dc, clockTime);

        var app = Application.getApp();
        if (app.getProperty("ShouldDisplayDecimalTime")) {
        	_decimalClockDrawer.draw(dc, clockTime);
        }
        if (app.getProperty("ShouldDisplaySteps")) {
            _stepsDrawer.draw(dc);
        }
        if (app.getProperty("ShouldDisplayBattery")) {
            _batteryDrawer.draw(dc);
        }
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
