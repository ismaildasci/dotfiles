<?php

/**
 * Rector Configuration - Nuno Maduro Style
 * Automated code refactoring for Laravel
 * Copy to your Laravel project root
 */

declare(strict_types=1);

use Rector\CodeQuality\Rector\Class_\InlineConstructorDefaultToPropertyRector;
use Rector\Config\RectorConfig;
use Rector\DeadCode\Rector\ClassMethod\RemoveUselessParamTagRector;
use Rector\DeadCode\Rector\ClassMethod\RemoveUselessReturnTagRector;
use Rector\Php83\Rector\ClassMethod\AddOverrideAttributeToOverriddenMethodsRector;
use Rector\Set\ValueObject\LevelSetList;
use Rector\Set\ValueObject\SetList;
use RectorLaravel\Set\LaravelSetList;

return RectorConfig::configure()
    ->withPaths([
        __DIR__.'/app',
        __DIR__.'/bootstrap/app.php',
        __DIR__.'/config',
        __DIR__.'/database',
        __DIR__.'/public',
        __DIR__.'/routes',
        __DIR__.'/tests',
    ])
    ->withSkip([
        __DIR__.'/bootstrap/cache',
        __DIR__.'/storage',
        __DIR__.'/vendor',
        AddOverrideAttributeToOverriddenMethodsRector::class,
        RemoveUselessParamTagRector::class,
        RemoveUselessReturnTagRector::class,
    ])
    ->withSets([
        // PHP Level
        LevelSetList::UP_TO_PHP_84,

        // Code Quality
        SetList::CODE_QUALITY,
        SetList::DEAD_CODE,
        SetList::EARLY_RETURN,
        SetList::TYPE_DECLARATION,
        SetList::PRIVATIZATION,
        SetList::INSTANCEOF,

        // Laravel Specific
        LaravelSetList::LARAVEL_120,
        LaravelSetList::LARAVEL_ARRAY_STR_FUNCTION_TO_STATIC_CALL,
        LaravelSetList::LARAVEL_CODE_QUALITY,
        LaravelSetList::LARAVEL_FACADE_ALIASES_TO_FULL_NAMES,
        LaravelSetList::LARAVEL_LEGACY_FACTORIES_TO_CLASSES,
    ])
    ->withRules([
        InlineConstructorDefaultToPropertyRector::class,
    ])
    ->withImportNames(removeUnusedImports: true)
    ->withCache('/tmp/rector')
    ->withParallel();
