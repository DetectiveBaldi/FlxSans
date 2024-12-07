package core;

import flixel.FlxG;

class Options
{
    public static var autoPause(get, set):Bool;

    @:noCompletion
    static function get_autoPause():Bool
    {
        return FlxG.save.data.options.autoPause ??= false;
    }

    @:noCompletion
    static function set_autoPause(_autoPause:Bool):Bool
    {
        FlxG.save.data.options.autoPause = _autoPause;

        return autoPause;
    }

    public static var fullscreen(get, set):Bool;

    @:noCompletion
    static function get_fullscreen():Bool
    {
        return FlxG.save.data.options.fullscreen ??= false;
    }

    @:noCompletion
    static function set_fullscreen(_fullscreen:Bool):Bool
    {
        FlxG.save.data.options.fullscreen = _fullscreen;

        return fullscreen;
    }

    public static var gpuCaching(get, set):Bool;

    @:noCompletion
    static function get_gpuCaching():Bool
    {
        return FlxG.save.data.options.gpuCaching ??= true;
    }

    @:noCompletion
    static function set_gpuCaching(_gpuCaching:Bool):Bool
    {
        FlxG.save.data.options.gpuCaching = _gpuCaching;

        return gpuCaching;
    }

    public static var soundStreaming(get, set):Bool;

    @:noCompletion
    static function get_soundStreaming():Bool
    {
        return FlxG.save.data.options.soundStreaming ??= true;
    }

    @:noCompletion
    static function set_soundStreaming(_soundStreaming:Bool):Bool
    {
        FlxG.save.data.options.soundStreaming = _soundStreaming;

        return soundStreaming;
    }
    
    public static var persistentCache(get, set):Bool;

    @:noCompletion
    static function get_persistentCache():Bool
    {
        return FlxG.save.data.options.persistentCache ??= true;
    }
    
    @:noCompletion
    static function set_persistentCache(_persistentCache:Bool):Bool
    {
        FlxG.save.data.options.persistentCache = _persistentCache;

        return _persistentCache;
    }

    public static function init():Void
    {
        FlxG.save.data.options ??= {};
    }
}