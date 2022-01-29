using Toybox.Graphics;
using Toybox.Lang;
using Toybox.System;
using Toybox.WatchUi;
using Toybox.Time;
using Toybox.Time.Gregorian;

class ClockBinaryComponent
{
    private var _binaryRenderer as BinaryRenderer;
    private var _app as Application.AppBase;
    private var _dc as Dc;

    function initialize()
    {
        _binaryRenderer = new BinaryRenderer(6);       
    }

    public function draw(dc as Dc) as Void
    {
        _app = Application.getApp();
        _dc = dc;

        var clockTime = System.getClockTime();
        var width = dc.getWidth()/2;
        var height = dc.getHeight();
        
        var font = Graphics.FONT_LARGE * 2;
        var justification = Graphics.TEXT_JUSTIFY_CENTER + Graphics.TEXT_JUSTIFY_VCENTER;
        
        dc.setColor(_app.getProperty("BinaryClockColor"), Graphics.COLOR_TRANSPARENT);
        dc.drawText(width, calculateHeightHour(), font, _binaryRenderer.fromDecimal(clockTime.hour), justification);
        dc.drawText(width, calculateHeightMin(), font, _binaryRenderer.fromDecimal(clockTime.min), justification);

        if (_app.getProperty("ShouldDisplaySeconds")) {
            dc.drawText(width, height/32 * 25, font, _binaryRenderer.fromDecimal(clockTime.sec), justification);
        }
    }

    private function calculateHeightHour() as Int
    {
        var height = _dc.getHeight();

        if (_app.getProperty("ShouldDisplaySeconds")) {
            return height/2 - 55;
        }
    
        return height/2 - 25;
    }

    private function calculateHeightMin() as Int
    {
        var height = _dc.getHeight();

        if (_app.getProperty("ShouldDisplaySeconds")) {
            return height/2;
        }
    
        return height/2 + 20;
    }
}
