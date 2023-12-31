import KeyboardArrowLeftIcon from "@mui/icons-material/KeyboardArrowLeft";
import { useNavigate } from "react-router-dom";


export default function BackButton() {
    const navigate = useNavigate()
    return (
            <div className="backButtonCarPage">
                <KeyboardArrowLeftIcon />
                <p onClick={() => navigate(-1)}>Back</p>
            </div>
    );
}
