import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

using Toybox.Graphics as Gfx;

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
        // Get and show the current time
        var clockTime = System.getClockTime();

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
        
        var hour = clockTime.hour;
        var font = Gfx.FONT_NUMBER_HOT;
       
        var widthScreen = dc.getWidth();
        var heightScreen = dc.getHeight();
        
        var timeHourString = clockTime.hour.format("%02d");
        var timeMinString = clockTime.min.format("%02d");
        var timeSecString = clockTime.sec.format("%02d");
        
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        dc.drawText(widthScreen/2, (heightScreen/2)-50, font, timeHourString, Gfx.TEXT_JUSTIFY_CENTER + Gfx.TEXT_JUSTIFY_VCENTER);
        dc.drawText(widthScreen/2, (heightScreen/2), font, timeMinString, Gfx.TEXT_JUSTIFY_CENTER + Gfx.TEXT_JUSTIFY_VCENTER);
        dc.drawText(widthScreen/2, (heightScreen/32)*24, font, timeSecString, Gfx.TEXT_JUSTIFY_CENTER + Gfx.TEXT_JUSTIFY_VCENTER);
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
