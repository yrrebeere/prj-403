import React, { useState, useEffect } from 'react';
import VendorService from '../../services/VendorService';
import styles from '../../styles/ComponentStyles.css';
import { useParams, useNavigate } from 'react-router-dom';

const EditVendorComponent = () => {
    const { vendor_id } = useParams();
    const [vendorName, setVendorName] = useState('');
    const [deliveryLocations, setDeliveryLocations] = useState('');
    const navigate = useNavigate();

    useEffect(() => {
        fetchData();
    }, [vendor_id]);

    const fetchData = async () => {
        try {
            const response = await VendorService.getVendorById(vendor_id);
            const { vendor_name, delivery_locations } = response.data;
            setVendorName(String(vendor_name)); // Ensure vendor_name is converted to string
            setDeliveryLocations(String(delivery_locations)); // Ensure delivery_locations is converted to string
        } catch (error) {
            console.error('Error fetching vendor details:', error);
        }
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        try {
            await VendorService.updateVendor(vendor_id, {
                vendor_name: String(vendorName), // Ensure vendorName is passed as a string
                delivery_locations: String(deliveryLocations) // Ensure deliveryLocations is passed as a string
            });
            console.log('Vendor updated successfully');
            navigate('/vendors');
        } catch (error) {
            console.error('Error updating vendor:', error);
        }
    };

    return (
        <div className={styles.body}>
            <h1>Edit Vendor</h1>
            <form onSubmit={handleSubmit}>
                <table className="table table-striped">
                    <tbody>
                    <tr>
                        <td>Vendor Name</td>
                        <td>
                            <input
                                type="text"
                                value={vendorName}
                                onChange={(e) => setVendorName(e.target.value)}
                            />
                        </td>
                    </tr>
                    <tr>
                        <td>Delivery Locations</td>
                        <td>
                            <input
                                type="text"
                                value={deliveryLocations}
                                onChange={(e) => setDeliveryLocations(e.target.value)}
                            />
                        </td>
                    </tr>
                    </tbody>
                </table>
                <br />
                <div align="left" style={{ margin: '20px' }}>
                    <button className="btn btn-primary" type="submit">Save</button>
                </div>
            </form>
        </div>
    );
};

export default EditVendorComponent;
