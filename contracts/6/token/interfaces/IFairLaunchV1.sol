pragma solidity 0.6.6;
pragma experimental ABIEncoderV2;

interface IFairLaunchV1 {
  struct UserInfo {
    uint256 amount;
    uint256 rewardDebt;
    uint256 bonusDebt;
    address fundedBy;
  }

  struct PoolInfo {
    address stakeToken;
    uint256 allocPoint;
    uint256 lastRewardBlock;
    uint256 accAlpacaPerShare;
    uint256 accAlpacaPerShareTilBonusEnd;
  }

  function alpacaPerBlock() external view returns (uint256);
  function totalAllocPoint() external view returns (uint256);
  function poolInfo(uint256 pid) external view returns (IFairLaunchV1.PoolInfo memory);
  function userInfo(uint256 pid, address user) external view returns (IFairLaunchV1.UserInfo memory);

  function poolLength() external view returns (uint256);

  function addPool(
    uint256 _allocPoint,
    address _stakeToken,
    bool _withUpdate
  ) external;

  function setPool(
    uint256 _pid,
    uint256 _allocPoint,
    bool _withUpdate
  ) external;

  function pendingAlpaca(uint256 _pid, address _user) external view returns (uint256);

  function updatePool(uint256 _pid) external;

  function deposit(address _for, uint256 _pid, uint256 _amount) external;

  function withdraw(address _for, uint256 _pid, uint256 _amount) external;

  function withdrawAll(address _for, uint256 _pid) external;

  function harvest(uint256 _pid) external;
}