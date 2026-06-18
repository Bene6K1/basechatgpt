import { toast } from 'react-toastify';

const errorNotify = (title: string) => {
  toast.error(title, {
    position: 'top-right',
    autoClose: 2250,
    hideProgressBar: true,
    closeOnClick: false,
    pauseOnHover: true,
    draggable: false,
    progress: undefined,
  });
};

const successNotify = (title: string) => {
  toast.success(title, {
    position: 'top-right',
    autoClose: 2250,
    hideProgressBar: true,
    closeOnClick: false,
    pauseOnHover: true,
    draggable: false,
    progress: undefined,
  });
};

export { errorNotify, successNotify };
