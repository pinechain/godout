## Base class for any kind of communication between different systems in the game.
## Essentially a less verbose wrapper around signals.
## Instantiate this class for each signal needed to communicate between systems.
class_name ParamEvent
extends Object


## Private encapsulated signal that will serve as bridge between systems.
signal _event(param)


## Triggers this event with a parameter [param param], if one is provided.
func trigger(param):
	_event.emit(param)


## Connects this event to the function [param callable]. For all effects, 
## whenever this event calls [method Event.trigger], [param callable] will
## also be invoked with the arguments passed on [method Event.trigger].
func sub(callable: Callable):
	_event.connect(callable)


## Disconnects [param callable] from this event. For all effects, [param callable]
## will no longer be invoked whenever [method Event.trigger] is called.
func unsub(callable: Callable):
	_event.disconnect(callable)