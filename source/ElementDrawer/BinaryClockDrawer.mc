using Toybox.Graphics;
using Toybox.Lang;
using Toybox.System;
using Toybox.WatchUi;
using Toybox.Time;
using Toybox.Time.Gregorian;

class BinaryClockDrawer
{
    private var _binaryRenderer as BinaryRenderer;

    function initialize()
    {
        _binaryRenderer = new BinaryRenderer(6);       
    }

    public function draw(dc as Dc) as Void
    {
        var app = Application.getApp();
        var clockTime = System.getClockTime();
        var width = dc.getWidth()/2;
        var height = dc.getHeight();
        var font = Graphics.FONT_LARGE * 2;
        var justification = Graphics.TEXT_JUSTIFY_CENTER + Graphics.TEXT_JUSTIFY_VCENTER;

        dc.setColor(app.getProperty("BinaryClockColor"), Graphics.COLOR_TRANSPARENT);
        dc.drawText(width, height/2 - 55, font, _binaryRenderer.fromDecimal(clockTime.hour), justification);
        dc.drawText(width, height/2, font, _binaryRenderer.fromDecimal(clockTime.min), justification);
        dc.drawText(width, height/32 * 25, font, _binaryRenderer.fromDecimal(clockTime.sec), justification);
    }
}
