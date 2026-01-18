# Infos
Diese Datei enthält alle Prompts, die für dieses Projekt verwendet wurden.

## Prompt 1
Generiere bitte eine einfache Taschenrechner App für iOS und watchOS, sowie macOS in SwiftUI

## Prompt 2
Bitte ändere das Design, sodass es moderner aussieht und verändere die Art und Weise, wie die Buttons funktionieren, damit die Funktionalität der App jederzeit einfach erweitert werden kann.

## Prompt 3
Bitte mach, dass man die Zeichen wie "+", "-" usw. in der Leiste oben sieht, und füge einen Rechnungsverlauf hinzu. Desweiteren, füge bitte mathematische Funktionen wie "sin", "cos" und "tan" hinzu und mathematische Zeichen wie π

## Prompt 4
Der Verlauf funktioniert gut, aber: Stelle sicher dass Rechnungen erst in den Verlauf gelegt werden, wenn das = Zeichen gedrückt wurde, des Weiteren bitte verändere die Art und Weise wie man "sin", "cos", "tan" etc. eingeben kann, sodass man z.B. sin drücken kann und danach die Zahl, dafür füge bitte "(" und ")" hinzu.

## Prompt 5
Wenn ich sin(03) eingebe bekomme ich den folgenden Fehler: Thread 1: "Unable to parse function name 'sin:' into supported selector (sin:) ". Bitte füge "," für Dezimalzahlen hinzu und stelle sicher, dass mathematische Fehler korrekt angezeigt werden und die App nicht zum abstürzen bringen.

## Prompt 6 
Wenn ich "sin(03)" eingebe bekomme ich immer noch diesen Fehler:

*** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: 'Unable to parse the format string "FUNCTION(sin:, 03) == 1"'
*** First throw call stack:
(
    0   CoreFoundation                      0x00000001804f71d0 __exceptionPreprocess + 172
    1   libobjc.A.dylib                     0x000000018009c094 objc_exception_throw + 72
    2   Foundation                          0x00000001810eb6b0 +[NSPredicate predicateWithFormat:arguments:] + 216
    3   Foundation                          0x000000018104ee24 +[NSExpression expressionWithFormat:arguments:] + 64
    4   Foundation                          0x0000000180f21d5c $sSo12NSExpressionC10FoundationE6format_ABSSh_s7CVarArg_pdtcfC + 104
    5   Taschenrechner.debug.dylib          0x0000000100c1ab5c $s14Taschenrechner14CalculatorViewV12safeEvaluateySdSgSSF + 128
    6   Taschenrechner.debug.dylib          0x0000000100c1862c $s14Taschenrechner14CalculatorViewV6handleyyAA10CalcButtonOF + 5096
    7   Taschenrechner.debug.dylib          0x0000000100c17234 $s14Taschenrechner14CalculatorViewV4bodyQrvg7SwiftUI05TupleC0VyAE0C0PAEE12cornerRadius_11antialiasedQr12CoreGraphics7CGFloatV_SbtFQOyAiEE10background_20ignoresSafeAreaEdgesQrqd___AE4EdgeO3SetVtAE    8   SwiftUI                             0x00000001da4cf920 $s7SwiftUI17ContextMenuBridgeC07contextD11Interaction_027willPerformPreviewActionForD4With8animatorySo09UIContextdG0C_So0oD13ConfigurationCSo0odG15CommitAnimating_ptFyycfU0_yyXEfU_TA + 24
    9   SwiftUI                             0x00000001dabd0db0 $sScM14assumeIsolated_4file4linexxyKScMYcXE_s12StaticStringVSutKs8SendableRzlFZyt_Tg5 + 132
    10  SwiftUI                             0x00000001dab9b7ac $s7SwiftUI12ButtonActionO14callAsFunctionyyF + 388
    11  SwiftUI                             0x00000001d9e8a8f0 $s7SwiftUI27PlatformItemListButtonStyleV8makeBody13configurationQrAA09PrimitivefG13ConfigurationV_tFyycAGYbcfu_yycfu0_TATm + 52
    12  SwiftUI                             0x00000001da46770c $s7SwiftUI14ButtonBehaviorV5ended33_AEEDD090E917AC57C12008D974DC6805LLyyF + 224
    13  SwiftUI                             0x00000001da46d258 $s7SwiftUI14ButtonBehaviorV4bodyQrvgyyYbcACyxGYbcfu_yyYbcfu0_TA + 32
    14  SwiftUI                             0x00000001dab47818 $s7SwiftUI14_ButtonGestureV12internalBodyQrvgAA04_MapD0VyAA09PrimitivecD0VytGyXEfU_ySo7CGPointVSgcfU0_yyScMYcXEfU_TA + 28
    15  SwiftUI                             0x00000001dabd0db0 $sScM14assumeIsolated_4file4linexxyKScMYcXE_s12StaticStringVSutKs8SendableRzlFZyt_Tg5 + 132
    16  SwiftUI                             0x00000001dab429f4 $s7SwiftUI14_ButtonGestureV12internalBodyQrvgAA04_MapD0VyAA09PrimitivecD0VytGyXEfU_ySo7CGPointVSgcfU0_ + 80
    17  SwiftUI                             0x00000001dab489a8 $s7SwiftUI31PrimitiveButtonGestureCallbacks33_2218E1141B3D7C3A65B6697591AFB638LLV8dispatch5phase5stateyycSgAA0E5PhaseOyAA0cdE4CoreACLLV5ValueVG_AA0d5PressQ0OztFyycfU0_TA + 84
    18  SwiftUICore                         0x00000001db026db4 $sypSgSo8_NSRangeVSpy10ObjectiveC8ObjCBoolVGIgnyy_AacGIegnyy_TRTA + 20
    19  SwiftUICore                         0x00000001db19d080 $sIeg_ytIegr_TR + 20
    20  SwiftUI                             0x00000001da0622c4 $sytIegr_Ieg_TR + 20
    21  SwiftUI                             0x00000001da31ede0 $s7SwiftUI17DragAndDropBridgeC15dragInteraction_16sessionWillBeginySo06UIDragH0C_So0L7Session_ptFyycfU0_ + 44
    22  SwiftUICore                         0x00000001db46a708 $s7SwiftUI6UpdateO15dispatchActionsyyFZ + 1092
    23  SwiftUICore                         0x00000001db469760 $s7SwiftUI6UpdateO3endyyFZ + 124
    24  SwiftUICore                         0x00000001db469498 $s7SwiftUI6UpdateO13enqueueAction6reason_s6UInt32VAA16CustomEventTraceV0eI4TypeO6ReasonOSg_yyctFZ + 188
    25  SwiftUI                             0x00000001da7288e0 $s7SwiftUI32UIKitResponderEventBindingBridgeC12flushActionsyyF + 400
    26  SwiftUI                             0x00000001da72893c $s7SwiftUI32UIKitResponderEventBindingBridgeC12flushActionsyyFTo + 24
    27  UIKitCore                           0x0000000185e04bb0 -[UIGestureRecognizerTarget _sendActionWithGestureRecognizer:] + 76
    28  UIKitCore                           0x0000000185e0dd84 _UIGestureRecognizerSendTargetActions + 88
    29  UIKitCore                           0x0000000185e0aa68 _UIGestureRecognizerSendActions + 296
    30  UIKitCore                           0x0000000185e0a62c -[UIGestureRecognizer _updateGestureForActiveEvents] + 320
    31  UIKitCore                           0x0000000185e0f2c8 -[UIGestureRecognizer gestureNode:didUpdatePhase:] + 296
    32  Gestures                            0x0000000230fec6a0 GFGestureNodeDefaultValue + 3760
    33  Gestures                            0x000000023100869c _swift_stdlib_malloc_size + 22468
    34  Gestures                            0x00000002310343dc __swift_memcpy24_8 + 19448
    35  Gestures                            0x000000023105b464 GFGestureNodeCoordinatorCreate + 2080
    36  UIKitCore                           0x0000000185dfc090 -[UIGestureEnvironment _updateForEvent:window:] + 468
    37  UIKitCore                           0x0000000186384450 -[UIWindow sendEvent:] + 2796
    38  UIKitCore                           0x00000001863622e4 -[UIApplication sendEvent:] + 376
    39  UIKitCore                           0x0000000186211270 __dispatchPreprocessedEventFromEventQueue + 1184
    40  UIKitCore                           0x0000000186213f24 __processEventQueue + 4800
    41  UIKitCore                           0x000000018620c4d0 updateCycleEntry + 168
    42  UIKitCore                           0x000000018582f378 _UIUpdateSequenceRunNext + 120
    43  UIKitCore                           0x00000001862640a4 schedulerStepScheduledMainSectionContinue + 56
    44  UpdateCycle                         0x00000002501912b4 _ZN2UC10DriverCore18continueProcessingEv + 80
    45  CoreFoundation                      0x00000001804563a4 __CFRUNLOOP_IS_CALLING_OUT_TO_A_SOURCE0_PERFORM_FUNCTION__ + 24
    46  CoreFoundation                      0x00000001804562ec __CFRunLoopDoSource0 + 168
    47  CoreFoundation                      0x0000000180455a78 __CFRunLoopDoSources0 + 220
    48  CoreFoundation                      0x0000000180454c4c __CFRunLoopRun + 760
    49  CoreFoundation                      0x000000018044fcec _CFRunLoopRunSpecificWithOptions + 496
    50  GraphicsServices                    0x0000000192a669bc GSEventRunModal + 116
    51  UIKitCore                           0x0000000186348574 -[UIApplication _run] + 772
    52  UIKitCore                           0x000000018634c79c UIApplicationMain + 124
    53  SwiftUI                             0x00000001da58d620 $s7SwiftUI17KitRendererCommon33_ACC2C5639A7D76F611E170E831FCA491LLys5NeverOyXlXpFAESpySpys4Int8VGSgGXEfU_ + 164
    54  SwiftUI                             0x00000001da58d368 $s7SwiftUI6runAppys5NeverOxAA0D0RzlF + 180
    55  SwiftUI                             0x00000001da31b42c $s7SwiftUI3AppPAAE4mainyyFZ + 148
    56  Taschenrechner.debug.dylib          0x0000000100c1359c $s14Taschenrechner13CalculatorAppV5$mainyyFZ + 40
    57  Taschenrechner.debug.dylib          0x0000000100c1c1a0 __debug_main_executable_dylib_entry_point + 12
    58  dyld                                0x0000000100d993d0 start_sim + 20
    59  ???                                 0x0000000100c6cd54 0x0 + 4307995988
)
libc++abi: terminating due to uncaught exception of type NSException
*** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: 'Unable to parse the format string "FUNCTION(sin:, 03) == 1"'
terminating due to uncaught exception of type NSException
CoreSimulator 1051.17.7 - Device: iPhone 17 (3C9DF8DD-313D-47E3-83DF-4B1F0F943DC7) - Runtime: iOS 26.2 (23C54) - DeviceType: iPhone 17

## Prompt 7
Das hat es nun behoben, füge als nächstes bitte den Verlauf als Popup-Fenster hinzu, anstatt ihn in der Mitte des Bildschirms zu zeigen.
