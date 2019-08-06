// Straight Jasmine testing without Angular's testing support

import { Context } from 'fabric-contract-api';
import { ChaincodeStub, ClientIdentity } from 'fabric-shim';
import { FabCar } from './fabcar';
import { Car } from './car';

import * as chai from 'chai';
import * as chaiAsPromised from 'chai-as-promised';
import * as sinon from 'sinon';
import * as sinonChai from 'sinon-chai';
import winston = require('winston');

chai.should();
chai.use(chaiAsPromised);
chai.use(sinonChai);

class TestContext implements Context {
  public stub: sinon.SinonStubbedInstance<ChaincodeStub> = sinon.createStubInstance(ChaincodeStub);
  public clientIdentity: sinon.SinonStubbedInstance<ClientIdentity> = sinon.createStubInstance(ClientIdentity);
  public logging = {
    getLogger: sinon.stub().returns(sinon.createStubInstance(winston.createLogger().constructor)),
    setLevel: sinon.stub(),
  };
}

describe('FabCar Contract', () => {
  let fabcarContract: FabCar;
  let ctx: TestContext;

  beforeEach(() => {
    fabcarContract = new FabCar();
    ctx = new TestContext();
    ctx.stub.getState.withArgs('1001').resolves(Buffer.from('{"value":"my asset 1001 value"}'));
    ctx.stub.getState.withArgs('1002').resolves(Buffer.from('{"value":"my asset 1002 value"}'));
    fabcarContract.initLedger(ctx);
  });

  it('#initLedger should initalize all cars', () => {

  });

  it('#queryAllCars should return all init cars', () => {
    let queriedCars = fabcarContract.queryAllCars(ctx);
    console.log(queriedCars);
  });
});