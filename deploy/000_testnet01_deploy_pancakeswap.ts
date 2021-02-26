import { HardhatRuntimeEnvironment } from 'hardhat/types';
import { DeployFunction } from 'hardhat-deploy/types';

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const { deployments, getNamedAccounts, network } = hre;
  const { deploy } = deployments;

  if (network.name !== 'testnet') {
    console.log('This deployment script should be run against testnet only')
    return
  }

  const { deployer } = await getNamedAccounts();

  await deploy('UniswapV2Factory', {
    from: deployer,
    args: [
      deployer,
    ],
    log: true,
    deterministicDeployment: false,
  });

  await deploy('WBNB', {
    from: deployer,
    contract: 'MockWBNB',
    log: true,
    deterministicDeployment: false,
  });

  const factory = await deployments.get('UniswapV2Factory');
  const wbnb = await deployments.get('WBNB');

  await deploy('UniswapV2Router02', {
    from: deployer,
    args: [
      factory.address,
      wbnb.address,
    ],
    log: true,
    deterministicDeployment: false,
  })
};

export default func;
func.tags = ['Testnet'];