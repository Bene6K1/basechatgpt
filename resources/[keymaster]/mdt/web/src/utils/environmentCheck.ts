const environmentCheck = (isDev: boolean) => {
  if (process.env.NODE_ENV === 'development' && isDev) {
    return true;
  }

  return false;
};

export default environmentCheck;
