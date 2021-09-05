using Toybox.Graphics;
using Toybox.Lang;
using Toybox.System;
using Toybox.WatchUi;
using Toybox.Time;
using Toybox.Time.Gregorian;

class BatteryDrawer
{
    public function draw(dc as Dc) as Void
    {
        var app = Application.getApp();
        if (!app.getProperty("ShouldDisplayBattery")) { 
            return;
        }

        var width = dc.getWidth();
        var height = dc.getHeight();

        var stats = System.getSystemStats();
        var text = "";
        if (stats.charging) {
            text += "Charging|";
        }
        text += Math.round(stats.battery).format("%d")+ "%";
        var font = Graphics.FONT_SMALL;
        var justification = Graphics.TEXT_JUSTIFY_RIGHT;

        dc.setColor(app.getProperty("BatteryColor"), Graphics.COLOR_TRANSPARENT);
        dc.drawText(width, height - 30, font, text, justification);
    }
}
