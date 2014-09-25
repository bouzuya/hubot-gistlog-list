{Robot, User, TextMessage} = require 'hubot'
assert = require 'power-assert'
path = require 'path'
sinon = require 'sinon'

describe 'gistlog-list', ->
  beforeEach (done) ->
    @sinon = sinon.sandbox.create()
    # for warning: possible EventEmitter memory leak detected.
    # process.on 'uncaughtException'
    @sinon.stub process, 'on', -> null
    @robot = new Robot(path.resolve(__dirname, '..'), 'shell', false, 'hubot')
    @robot.adapter.on 'connected', =>
      @robot.load path.resolve(__dirname, '../../src/scripts')
      setTimeout done, 10 # wait for parseHelp()
    @robot.run()

  afterEach (done) ->
    @robot.brain.on 'close', =>
      @sinon.restore()
      done()
    @robot.shutdown()

  describe 'listeners[0].regex', ->
    describe 'valid patterns', ->
      beforeEach ->
        @tests = [
          message: '@hubot gistlog list'
          matches: ['@hubot gistlog list', undefined]
        ,
          message: '@hubot gistlog list bouzuya'
          matches: ['@hubot gistlog list bouzuya', 'bouzuya']
        ]

      it 'should match', ->
        @tests.forEach ({ message, matches }) =>
          callback = @sinon.spy()
          @robot.listeners[0].callback = callback
          sender = new User 'bouzuya', room: 'hitoridokusho'
          @robot.adapter.receive new TextMessage(sender, message)
          actualMatches = callback.firstCall.args[0].match.map((i) -> i)
          assert callback.callCount is 1
          assert.deepEqual actualMatches, matches

  describe 'listeners[0].callback', ->
    beforeEach ->
      @hello = @robot.listeners[0].callback

    describe 'receive "@hubot gistlog list bouzuya"', ->
      beforeEach ->
        responseBody = [
          description: '2014-01-01 title'
          html_url: 'http://example.com/'
        ]
        httpGetResponse = @sinon.stub()
        httpGetResponse
          .onFirstCall()
          .callsArgWith 0, null, null, JSON.stringify(responseBody)
        httpGet = @sinon.stub()
        httpGet.onFirstCall().returns httpGetResponse
        http = @sinon.stub()
        http.onFirstCall().returns get: httpGet
        @send = @sinon.spy()
        @hello
          match: ['@hubot gistlog list bouzuya', 'bouzuya']
          send: @send
          http: http

      it 'send "hello!"', ->
        assert @send.callCount is 1
        assert @send.firstCall.args[0] is '2014-01-01 title http://example.com/'

  describe 'robot.helpCommands()', ->
    it 'should be ["hubot gistlog list <username> - lists gistlog"]', ->
      assert.deepEqual @robot.helpCommands(), [
        "hubot gistlog list <username> - lists gistlog"
      ]
