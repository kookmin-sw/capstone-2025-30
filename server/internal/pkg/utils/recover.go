package utils

import pb "server/gen"

func RecoverToEError(recovered interface{}, defaultError pb.EError) pb.EError {
	var err pb.EError

	switch val := recovered.(type) {
	case pb.EError:
		err = val
	default:
		err = defaultError
	}

	return err
}
