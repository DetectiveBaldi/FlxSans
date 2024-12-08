package game;

import flixel.FlxG;
import flixel.FlxSprite;

import flixel.sound.FlxSound;

import flixel.util.FlxColor;

import core.Assets;
import core.Paths;

import ui.BorderedBox;

class Soul extends FlxSprite
{
    public var mode(default, set):SoulMode;

    @:noCompletion
    function set_mode(_mode:SoulMode):SoulMode
    {
        mode = _mode;

        angle = 0.0;

        color = mode == RED ? FlxColor.RED : FlxColor.BLUE;

        flip();

        return _mode;
    }

    public var borderedBox:BorderedBox;

    public var bell:FlxSound;

    public var canJump:Bool;

    public var jumpHeight:Float;

    public function new(x:Float = 0.0, y:Float = 0.0, mode:SoulMode = RED):Void
    {
        super(x, y, Assets.getGraphic(Paths.png("assets/images/game/Soul/soul")));

        scale.set(1.85, 1.85);

        updateHitbox();

        this.mode = mode;

        bell = FlxG.sound.load(Assets.getSound(Paths.wav("assets/sounds/game/Soul/bell"), false));

        canJump = false;

        jumpHeight = 0.0;
    }

    override function update(elapsed:Float):Void
    {
        super.update(elapsed);

        if (borderedBox.width <= width || borderedBox.height <= height)
            return;

        if (FlxG.keys.pressed.LEFT && ((angle != 90.0 && angle != 270.0) || mode == RED))
            x -= width * (FlxG.keys.pressed.X ? 5.0 : 10.0) * elapsed;

        if (FlxG.keys.pressed.DOWN && ((angle != 180.0 && angle != 0.0) || mode == RED))
            y += height * (FlxG.keys.pressed.X ? 5.0 : 10.0) * elapsed;

        if (FlxG.keys.pressed.UP && ((angle != 0.0 && angle != 180.0) || mode == RED))
            y -= height * (FlxG.keys.pressed.X ? 5.0 : 10.0) * elapsed;

        if (FlxG.keys.pressed.RIGHT && ((angle != 270.0 && angle != 90.0) || mode == RED))
            x += width * (FlxG.keys.pressed.X ? 5.0 : 10.0) * elapsed;

        while (x < borderedBox.x + borderedBox.borderWidth * 0.5)
            x = borderedBox.x + borderedBox.borderWidth * 0.5;

        while (y > borderedBox.y + borderedBox.height + borderedBox.borderHeight * 0.5 - height)
            y = borderedBox.y + borderedBox.height + borderedBox.borderHeight * 0.5 - height;

        while (y < borderedBox.y + borderedBox.borderHeight * 0.5)
            y = borderedBox.y + borderedBox.borderHeight * 0.5;

        while (x > borderedBox.x + borderedBox.width + borderedBox.borderWidth * 0.5 - width)
            x = borderedBox.x + borderedBox.width + borderedBox.borderWidth * 0.5 - width;

        switch (mode:SoulMode)
        {
            case RED:
            {
                
            }

            case BLUE:
            {
                switch (angle:Float)
                {
                    case 90.0:
                    {
                        acceleration.set(-750.0, 0.0);

                        if (FlxG.keys.pressed.RIGHT && canJump && jumpHeight < 75.0)
                        {
                            if (velocity.x <= 0.0)
                                velocity.x = 0.0;
        
                            velocity.x += width * 100.0 * elapsed;
        
                            jumpHeight += width * 15.0 * elapsed;
                        }

                        if (FlxG.keys.justReleased.RIGHT && canJump)
                            canJump = false;

                        if (x == borderedBox.x + borderedBox.borderWidth * 0.5)
                        {
                            canJump = true;
        
                            jumpHeight = 0.0;
                        }
                    }

                    case 180.0:
                    {
                        acceleration.set(0.0, -750.0);

                        if (FlxG.keys.pressed.DOWN && canJump && jumpHeight < 75.0)
                        {
                            if (velocity.y <= 0.0)
                                velocity.y = 0.0;
        
                            velocity.y += height * 100.0 * elapsed;
        
                            jumpHeight += height * 15.0 * elapsed;
                        }

                        if (FlxG.keys.justReleased.DOWN && canJump)
                            canJump = false;

                        if (y == borderedBox.y + borderedBox.borderHeight * 0.5)
                        {
                            canJump = true;
        
                            jumpHeight = 0.0;
                        }
                    }

                    case 0.0:
                    {
                        acceleration.set(0.0, 750.0);

                        if (FlxG.keys.pressed.UP && canJump && jumpHeight < 75.0)
                        {
                            if (velocity.y > 0)
                                velocity.y = 0.0;
        
                            velocity.y -= height * 100.0 * elapsed;
        
                            jumpHeight += height * 15.0 * elapsed;
                        }

                        if (FlxG.keys.justReleased.UP && canJump)
                            canJump = false;

                        if (y == borderedBox.y + borderedBox.height + borderedBox.borderHeight * 0.5 - height)
                        {
                            canJump = true;
        
                            jumpHeight = 0.0;
                        }
                    }

                    case 270.0:
                    {
                        acceleration.set(750.0, 0.0);

                        if (FlxG.keys.pressed.LEFT && canJump && jumpHeight < 75.0)
                        {
                            if (velocity.x > 0.0)
                                velocity.x = 0.0;
        
                            velocity.x -= width * 100.0 * elapsed;
        
                            jumpHeight += width * 15.0 * elapsed;
                        }

                        if (FlxG.keys.justReleased.LEFT && canJump)
                            canJump = false;

                        if (x == borderedBox.x + borderedBox.width + borderedBox.borderWidth * 0.5 - width)
                        {
                            canJump = true;
        
                            jumpHeight = 0.0;
                        }
                    }
                }
            }
        }
    }

    public function flip():Void
    {
        velocity.set();

        acceleration.set();

        canJump = false;

        jumpHeight = 0.0;
    }
}

enum SoulMode
{
    RED;

    BLUE;
}