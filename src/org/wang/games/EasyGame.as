package org.wang.games 
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import org.osflash.signals.Signal;
	import org.wang.interfaces.games.IEasyGame;
	import org.wang.utils.EasyCountTimer;
	
	/**
	 * ...
	 * @author leo.wang
	 */
	public class EasyGame implements IEasyGame 
	{
		protected var _gameTimer:EasyCountTimer;
		protected var _gameOverSignal:Signal;
		protected var _gameScore:Number
		protected var _gameState:String;
		protected var _gameStateSignal:Signal;
		protected var _gameTiming:int;
		protected var _gameTimeSignal:Signal;
		protected var _isTimeGame:Boolean;
		//private var 
		public function EasyGame() 
		{
			_gameTiming = 10000;
			_gameTimer = new EasyCountTimer(_gameTiming,false);
			_gameTimer.ringSignal.add(onGameTimeOver);
			_gameOverSignal = new Signal(Boolean);
			_gameStateSignal = new Signal(String);
			_isTimeGame = true;
		}
		public function get gameTimer():EasyCountTimer
		{
			return _gameTimer;
		}
		protected function onGameTimeOver(e:EasyCountTimer):void 
		{
			_gameState = EasyGameState.GAME_TIMEOUT;
			_gameStateSignal.dispatch(_gameState);
			_gameOverSignal.dispatch(false);
		}
		
		/* INTERFACE org.wang.interfaces.games.IEasyGame */
		public function gameReady():void
		{
			_gameState = EasyGameState.GAME_READY;
			_gameStateSignal.dispatch(_gameState);
		}
		public function gameLose():void
		{
			//_gameTimer.
			if (_isTimeGame)
			{
				_gameTimer.stop();
			}
			_gameState = EasyGameState.GAME_LOSE;
			_gameStateSignal.dispatch(_gameState);
			_gameOverSignal.dispatch(false);
		}
		public function gameWin():void
		{
			if (_isTimeGame)
			{
				_gameTimer.stop();
			}
			_gameState = EasyGameState.GAME_WIN;
			_gameStateSignal.dispatch(_gameState);
			_gameOverSignal.dispatch(true);
		}
		public function startGame():void 
		{
			if (_isTimeGame)
			{
				_gameTimer.start(_gameTiming);
			}
			_gameState = EasyGameState.GAME_START;
			_gameStateSignal.dispatch(_gameState);
		}
		
		public function stopGame():void 
		{
			if (_isTimeGame)
			{
				_gameTimer.stop();
			}
			_gameState = EasyGameState.GAME_STOP;
			_gameStateSignal.dispatch(_gameState);
		}
		
		public function pauseGame():void 
		{
			if (_isTimeGame)
			{
				_gameTimer.pause();
			}
			_gameState = EasyGameState.GAME_PAUSE;
			_gameStateSignal.dispatch(_gameState);
		}
		
		public function resumeGame():void 
		{
			if (_isTimeGame && !_gameTimer.running)
			{
				_gameTimer.resume();
			}
			_gameState = EasyGameState.GAME_RESUME;
			_gameStateSignal.dispatch(_gameState);
		}
		
		public function get gameOverSignal():Signal 
		{
			return _gameOverSignal;
		}
		
		public function get gameStateSignal():Signal 
		{
			return _gameStateSignal;
		}
		
		public function get gameScore():Number 
		{
			return _gameScore;
		}
		public function set gameScore(n:Number):void 
		{
			_gameScore = n;
		}
		public function set gameTiming(value:int):void 
		{
			_gameTiming = value;
		}
		
		public function get gameTiming():int 
		{
			return _gameTiming;
		}
		
		public function get gameTimeSignal():Signal 
		{
			return _gameTimeSignal;
		}
		public function get gameState():String
		{
			return _gameState;
		}
		
		public function get isTimeGame():Boolean 
		{
			return _isTimeGame;
		}
		
		public function set isTimeGame(value:Boolean):void 
		{
			_isTimeGame = value;
		}
	}

}