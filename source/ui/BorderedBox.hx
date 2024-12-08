package ui;

import flixel.FlxG;
import flixel.FlxSprite;

import flixel.group.FlxGroup;

import flixel.math.FlxMath;
import flixel.math.FlxRect;

import flixel.util.FlxAxes;

import core.Assets;
import core.Paths;

import game.Soul;

class BorderedBox extends FlxGroup
{
    public var bounds:FlxRect;

    public var x(get, set):Float;

    @:noCompletion
    function get_x():Float
    {
        return bounds.x;
    }
    
    @:noCompletion
    function set_x(_x:Float):Float
    {
        bounds.x = _x;

        return x;
    }
    
    public var y(get, set):Float;

    @:noCompletion
    function get_y():Float
    {
        return bounds.y;
    }
    
    @:noCompletion
    function set_y(_y:Float):Float
    {
        bounds.y = _y;

        return y;
    }

    public var width(get, set):Float;

    @:noCompletion
    function get_width():Float
    {
        return bounds.width;
    }

    @:noCompletion
    function set_width(_width:Float):Float
    {
        bounds.width = _width;

        return width;
    }

    public var height(get, set):Float;

    @:noCompletion
    function get_height():Float
    {
        return bounds.height;
    }

    @:noCompletion
    function set_height(_height:Float):Float
    {
        bounds.height = _height;

        return height;
    }

    public var borderWidth:Float;

    public var borderHeight:Float;

    public var resizeSpeed:Float;

    public var center:FlxSprite;

    public var border:FlxSprite;

    public function new(x:Float = 0.0, y:Float = 0.0, width:Float = 240.0, height:Float = 240.0, borderWidth:Float = 16.0, borderHeight:Float = 16.0, resizeSpeed:Float = 5.0):Void
    {
        super();

        bounds = FlxRect.get(x, y, width, height);

        this.borderWidth = borderWidth;

        this.borderHeight = borderHeight;

        this.resizeSpeed = resizeSpeed;

        center = new FlxSprite(0.0, 0.0, Assets.getGraphic(Paths.png("assets/images/ui/borderedBox/center")));

        center.active = false;

        center.updateHitbox();

        add(center);

        border = new FlxSprite(0.0, 0.0, Assets.getGraphic(Paths.png("assets/images/ui/borderedBox/border")));

        border.active = false;

        border.updateHitbox();

        insert(0, border);
    }

    override function update(elapsed:Float):Void
    {
        super.update(elapsed);

        center.scale.set(width / center.frameWidth + (center.scale.x - width / center.frameWidth) * Math.exp(-resizeSpeed * elapsed), height / center.frameHeight + (center.scale.y - height / center.frameHeight) * Math.exp(-resizeSpeed * elapsed));

        center.updateHitbox();

        center.setPosition(x + (width - center.width) * 0.5 + borderWidth * 0.5, y + (height - center.height) * 0.5 + borderHeight * 0.5);

        border.scale.set((width + borderWidth) / border.frameWidth + (border.scale.x - (width + borderWidth) / border.frameWidth) * Math.exp(-resizeSpeed * elapsed), (height + borderHeight) / border.frameHeight + (border.scale.y - (height + borderHeight) / border.frameHeight) * Math.exp(-resizeSpeed * elapsed));

        border.updateHitbox();

        border.setPosition(x + borderWidth * 0.5 - (border.width - width) * 0.5, y + borderHeight * 0.5 - (border.height - height) * 0.5);
    }

    public function setPosition(_x:Float = 0.0, _y:Float = 0.0):Void
    {
        x = _x;

        y = _y;
    }

    public function screenCenter(axes:FlxAxes = XY):BorderedBox
    {
        if (axes.x)
            x = (FlxG.width - width - borderWidth) * 0.5;

        if (axes.y)
            y = (FlxG.height - height - borderHeight) * 0.5;

        return this;
    }

    public function setSize(_width:Float = 240.0, _height:Float = 240.0, borderWidth:Float = 16.0, borderHeight:Float = 16.0):Void
    {
        width = _width;

        height = _height;

        this.borderWidth = borderWidth;

        this.borderHeight = borderHeight;
    }
}