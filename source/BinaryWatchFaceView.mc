using Toybox.Graphics;
using Toybox.Lang;
using Toybox.System;
using Toybox.WatchUi;
using Toybox.Time;
using Toybox.Time.Gregorian;

class BinaryWatchFaceView extends WatchUi.WatchFace
{
    private var _components as Array<Object>;

    function initialize() as Void
    {
        WatchFace.initialize();
        _components = new Array<Object>[5];
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void
    {
        setLayout(Rez.Layouts.WatchFace(dc));

        _components[0] = new BatteryComponent();
        _components[1] = new BinaryClockComponent();
        _components[2] = new DateLineComponent();
        _components[3] = new DecimalClockComponent();
        _components[4] = new StepsComponent();
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

        for (var i = 0; i < _components.size(); i++) {
            _components[i].draw(dc);
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
