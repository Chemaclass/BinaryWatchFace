using Toybox.Graphics;
using Toybox.Lang;
using Toybox.System;
using Toybox.WatchUi;
using Toybox.Time;
using Toybox.Time.Gregorian;

class StepsDrawer
{
    public function draw(dc as Dc) as Void
    {
        var app = Application.getApp();
        if (!app.getProperty("ShouldDisplaySteps")) { 
            return; 
        }

        var info = ActivityMonitor.getInfo();
        var text = "Steps:" + Math.round(info.steps).format("%d");
        var font = Graphics.FONT_SMALL;
        var height = dc.getHeight();
        var justification = Graphics.TEXT_JUSTIFY_LEFT;

        dc.setColor(app.getProperty("StepsColor"), Graphics.COLOR_TRANSPARENT);
        dc.drawText(0, height - 30, font, text, justification);
    }

}
